import 'dart:convert';
import 'package:adgenerator/models/question_model.dart';
import 'package:http/http.dart' as http;

Future<List<QuestionModel>> fetchQuestions() async {
  // استبدل الرابط التالي برابط الـ API الخاص بـ Laravel لديك
  // مثال: http://10.0.2.2:8000/api/questions (للمحاكي)
  final url = Uri.parse('http://192.168.1.4:8000/api/questions');

  try {
    final response = await http.get(url);

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      print("the connection established");
      return data.map((json) => QuestionModel.fromJson(json)).toList();
    } else {
      throw Exception('فشل في تحميل الأسئلة: ${response.statusCode}');
    }
  } catch (e) {
    // في حال حدوث خطأ، يمكنك إرجاع قائمة فارغة أو رمي خطأ
    // هنا سنقوم بمحاكاة البيانات التي أرسلتها لي للتجربة في حال لم يكن السيرفر جاهزاً
    return getDummyData();
  }
}

// دالة مؤقتة لمحاكاة البيانات التي أرسلتها في سؤالك (للتجربة فقط)
List<QuestionModel> getDummyData() {
  String jsonStr =
      '''[{"id":1,"qus_title":"ما هو   من هذا الإعلان؟","qus_content":"no body","qus_options":"هل هو زيادة  بالعلامة ;زيادة المبيعات;جذب عملاء جدد;تقديم عرض خاص;تثقيف  حول ميزة جديدة","qus_type":"radio","created_at":"-000001-11-30T00:00:00.000000Z","updated_at":null},{"id":2,"qus_title":"ما هو المنتج أو الخدمة المعلن عنها؟","qus_content":"no body","qus_options":";ما هي  الرئيسية التي  المنتج للعميل\\n;ما الذي يميز هذا المنتج أو الخدمة عن المنافسين؟\\nما هي القيمة الفريدة المقترحة (Unique Value Proposition)؟","qus_type":"radio","created_at":null,"updated_at":null},{"id":3,"qus_title":"من هو الجمهور المستهدف بدقة؟","qus_content":"تحديد الفئة العمرية،الجنس,الموقع الجغرافي,الاهتمامات, السلوكيات,المستوى التعليمي","qus_options":"no option","qus_type":"input","created_at":null,"updated_at":null},{"id":7,"qus_title":"ما هي الرسالة الأساسية التي نريد إيصالها للجمهور؟","qus_content":"(يجب أن تكون واضحة وموجزة","qus_options":"no option","qus_type":"input","created_at":null,"updated_at":null}]''';
  List<dynamic> data = json.decode(jsonStr);
  return data.map((json) => QuestionModel.fromJson(json)).toList();
}
