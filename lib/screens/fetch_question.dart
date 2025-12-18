import 'package:adgenerator/functions.dart';
import 'package:adgenerator/models/question_model.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

// تأكد من استيراد الـ Model هنا

class AdWizardScreen extends StatefulWidget {
  const AdWizardScreen({Key? key}) : super(key: key);

  @override
  State<AdWizardScreen> createState() => _AdWizardScreenState();
}

class _AdWizardScreenState extends State<AdWizardScreen> {
  // متغير للتحكم في الصفحات (لعمل أنيميشن الانتقال)
  final PageController _pageController = PageController();

  late Future<Map<int, List<QuestionModel>>> _groupedQuestionsFuture;

  // تخزين الإجابات: المفتاح هو ID السؤال، القيمة قد تكون نص أو قائمة نصوص (للـ check)
  final Map<int, dynamic> _userAnswers = {};

  int _currentGroupIndex = 0;
  int _totalGroups = 1;

  @override
  void initState() {
    super.initState();
    _groupedQuestionsFuture = fetchAndGroupQuestions();
  }

  // دالة لجلب البيانات وتقسيمها لمجموعات

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('مولد الإعلانات الذكي')),
      body: FutureBuilder<Map<int, List<QuestionModel>>>(
        future: _groupedQuestionsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('خطأ: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('لا توجد أسئلة'));
          }

          final groupedQuestions = snapshot.data!;
          final groupKeys = groupedQuestions.keys.toList();
          _totalGroups = groupKeys.length;

          return Column(
            children: [
              // 1. شريط التقدم
              _buildProgressBar(),

              // 2. منطقة عرض الأسئلة (PageView)
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  physics:
                      const NeverScrollableScrollPhysics(), // منع السحب اليدوي
                  itemCount: _totalGroups,
                  onPageChanged: (index) {
                    setState(() {
                      _currentGroupIndex = index;
                    });
                  },
                  itemBuilder: (context, index) {
                    int groupId = groupKeys[index];
                    List<QuestionModel> questions = groupedQuestions[groupId]!;
                    return _buildGroupPage(questions);
                  },
                ),
              ),

              // 3. أزرار التحكم (السابق - التالي)
              _buildBottomControls(),
            ],
          );
        },
      ),
    );
  }

  // ودجت شريط التقدم
  Widget _buildProgressBar() {
    double progress = (_currentGroupIndex + 1) / _totalGroups;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "المجموعة ${_currentGroupIndex + 1} من $_totalGroups",
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: Colors.grey),
          ),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: progress,
            backgroundColor: Colors.grey[200],
            color: Colors.blueAccent,
            minHeight: 8,
            borderRadius: BorderRadius.circular(4),
          ),
        ],
      ),
    );
  }

  // صفحة تعرض قائمة أسئلة لمجموعة محددة
  Widget _buildGroupPage(List<QuestionModel> questions) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      itemCount: questions.length,
      separatorBuilder: (ctx, i) => const SizedBox(height: 20),
      itemBuilder: (context, index) {
        return _buildQuestionCard(questions[index]);
      },
    );
  }

  // بناء كرت السؤال
  Widget _buildQuestionCard(QuestionModel question) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(question.title,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            if (question.content!.isNotEmpty &&
                !question.content!.contains("no body"))
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(question.content!,
                    style: TextStyle(color: Colors.grey[600], fontSize: 13)),
              ),
            const SizedBox(height: 12),
            _buildInputWidget(question),
          ],
        ),
      ),
    );
  }

  // تحديد نوع الإدخال (تمت إضافة Checkbox)
  Widget _buildInputWidget(QuestionModel question) {
    switch (question.type) {
      case 'input':
        return TextFormField(
          initialValue: _userAnswers[question.id] ?? '',
          decoration: const InputDecoration(
              border: OutlineInputBorder(), hintText: 'إجابتك...'),
          maxLines: 2,
          onChanged: (val) => _userAnswers[question.id] = val,
        );

      case 'radio':
        return Column(
          children: question.optionsList.map((opt) {
            return RadioListTile<String>(
              title: Text(opt),
              value: opt,
              groupValue: _userAnswers[question.id],
              onChanged: (val) {
                setState(() => _userAnswers[question.id] = val);
              },
            );
          }).toList(),
        );

      case 'list':
        return DropdownButtonFormField<String>(
          decoration: const InputDecoration(border: OutlineInputBorder()),
          value: _userAnswers[question.id],
          items: question.optionsList
              .map((opt) => DropdownMenuItem(value: opt, child: Text(opt)))
              .toList(),
          onChanged: (val) => setState(() => _userAnswers[question.id] = val),
        );

      case 'check': // النوع الجديد: اختيار متعدد
        // التأكد من أن القيمة الحالية هي قائمة، وإلا تهيئتها
        List<String> currentSelections = [];
        if (_userAnswers[question.id] is List) {
          currentSelections = List<String>.from(_userAnswers[question.id]);
        }

        return Column(
          children: question.optionsList.map((opt) {
            bool isSelected = currentSelections.contains(opt);
            return CheckboxListTile(
              title: Text(opt),
              value: isSelected,
              onChanged: (bool? checked) {
                setState(() {
                  if (checked == true) {
                    currentSelections.add(opt);
                  } else {
                    currentSelections.remove(opt);
                  }
                  // حفظ القائمة المحدثة في المتغير الرئيسي
                  _userAnswers[question.id] = currentSelections;
                });
              },
            );
          }).toList(),
        );

      default:
        return const Text('نوع غير معروف');
    }
  }

  // شريط الأزرار السفلي (السابق - التالي)
  Widget _buildBottomControls() {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // زر السابق
          if (_currentGroupIndex > 0)
            ElevatedButton.icon(
              onPressed: () {
                _pageController.previousPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut);
              },
              icon: const Icon(Icons.arrow_back),
              label: const Text("السابق"),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
            )
          else
            const SizedBox(), // مساحة فارغة للحفاظ على التنسيق

          // زر التالي أو إنهاء
          ElevatedButton.icon(
            onPressed: () {
              if (_currentGroupIndex < _totalGroups - 1) {
                // الانتقال للمجموعة التالية
                _pageController.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut);
              } else {
                // إنهاء وإرسال البيانات
                _submitData();
              }
            },
            icon: Icon(_currentGroupIndex == _totalGroups - 1
                ? Icons.check
                : Icons.arrow_forward),
            label: Text(_currentGroupIndex == _totalGroups - 1
                ? "إرسال وتوليد"
                : "التالي"),
            style: ElevatedButton.styleFrom(
              backgroundColor: _currentGroupIndex == _totalGroups - 1
                  ? Colors.green
                  : Colors.blue,
              foregroundColor: Colors.white, // لون النص
            ),
          ),
        ],
      ),
    );
  }

  void _submitData() {
    // 1. تحويل البيانات إلى صيغة يقبلها JSON
    // نحول المفتاح من int إلى String
    Map<String, dynamic> finalData = {};

    _userAnswers.forEach((key, value) {
      // تحويل المفتاح لنص
      String stringKey = key.toString();

      // التأكد من أن القيمة ليست Set أو Iterable (تحويلها لقائمة)
      if (value is Set || value is Iterable) {
        finalData[stringKey] = value.toList();
      } else {
        finalData[stringKey] = value;
      }
    });

    try {
      String jsonBody = jsonEncode(finalData);
      print("=== البيانات جاهزة للإرسال ===");
      print(jsonBody);
      _sendToLaravel(jsonBody);
    } catch (e) {
      print("خطأ في معالجة البيانات: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('حدث خطأ أثناء تجهيز البيانات: $e')),
      );
    }
  }

  Future<void> _sendToLaravel(String jsonBody) async {
    final url = Uri.parse('http://192.168.1.3:8000/api/answars');

    //try {
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonBody,
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('تم إرسال الإجابات بنجاح!')),
      );
      var jsonResponse = jsonDecode(response.body);
      String adText = jsonResponse['ad_content'];
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text("الإعلان المولد"),
          content: SingleChildScrollView(child: Text(adText)),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(ctx), child: Text("حسناً"))
          ],
        ),
      );
    } else {
      throw Exception('فشل السيرفر: ${response.statusCode}');
    }
    /* } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('فشل الاتصال: $e')),
      );
    }*/
  }
}
