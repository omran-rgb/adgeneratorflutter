import 'dart:convert';
import 'package:adgenerator/models/question_model.dart';
import 'package:http/http.dart' as http;

Future<Map<int, List<QuestionModel>>> fetchAndGroupQuestions() async {
  // استبدل بالرابط الحقيقي
  final url = Uri.parse('http://192.168.1.3:8000/api/questions');

  try {
    final response = await http.get(url);
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      print(data);
      List<QuestionModel> allQuestions =
          data.map((json) => QuestionModel.fromJson(json)).toList();
      for (int i = 0; i < allQuestions.length; i++) {
        print(allQuestions[i].rawOptions);
      }

      // تجميع الأسئلة بناءً على group_id
      Map<int, List<QuestionModel>> grouped = {};
      for (var q in allQuestions) {
        if (!grouped.containsKey(q.groupId)) {
          grouped[q.groupId] = [];
        }
        grouped[q.groupId]!.add(q);
      }

      // ترتيب المجموعات للتأكد من تسلسلها (1, 2, 3...)
      return Map.fromEntries(
          grouped.entries.toList()..sort((a, b) => a.key.compareTo(b.key)));
    } else {
      throw Exception('Error loading data');
    }
  } catch (e) {
    // بيانات وهمية للتجربة في حال فشل الاتصال
    return _getDummyGroupedData();
  }
}

Map<int, List<QuestionModel>> _getDummyGroupedData() {
  // هذه البيانات للمحاكاة فقط
  return {
    1: [
      QuestionModel(
          id: 1,
          groupId: 1,
          title: "سؤال نصي 1",
          content: "",
          rawOptions: "",
          type: "input"),
      QuestionModel(
          id: 2,
          groupId: 1,
          title: "سؤال راديو 1",
          content: "",
          rawOptions: "نعم|لا",
          type: "radio"),
      QuestionModel(
          id: 5,
          groupId: 1,
          title: "مجموعة الأسئلة تجربة",
          content: "في حال عدم وجود انترنت",
          rawOptions: "انتظر حتى يعود الاتصال وقم بالتحديث",
          type: "radio")
    ],
    2: [
      QuestionModel(
          id: 3,
          groupId: 2,
          title: "ما هي المنصات؟",
          content: "اختر كل ما ينطبق",
          rawOptions: "فيسبوك;انستجرام;تيك توك",
          type: "check"),
    ],
    3: [
      QuestionModel(
          id: 4,
          groupId: 3,
          title: "الميزانية؟",
          content: "",
          rawOptions: "منخفضة|متوسطة|عالية",
          type: "list"),
    ]
  };
}
