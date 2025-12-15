class QuestionModel {
  final int id;
  final int groupId;
  final String title;
  final String? content;
  final String? rawOptions;
  final String type;

  QuestionModel({
    required this.id,
    required this.groupId,
    required this.title,
    required this.content,
    required this.rawOptions,
    required this.type,
  });

  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    return QuestionModel(
      id: json['id'],
      groupId: json['group_id'] ?? 1,
      title: json['title'] ?? '',
      content: json['content'] ?? '',
      rawOptions: json['options'] ?? '',
      type: json['type'] ?? 'input',
    );
  }

  // دالة مساعدة لتحويل نص الخيارات إلى قائمة نظيفة
  List<String> get optionsList {
    if (rawOptions == "no option" || rawOptions!.isEmpty) return [];
    // نقوم بتقسيم النص بناءً على الفاصلة المنقوطة ونحذف الفراغات والأسطر الجديدة
    return rawOptions!
        .split('|')
        .map((e) => e.trim())
        .where((element) => element.isNotEmpty)
        .toList();
  }
}
