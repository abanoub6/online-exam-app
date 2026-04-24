class AnswerEntity {
  final String answer;
  final String key;

  const AnswerEntity({required this.answer, required this.key});

  factory AnswerEntity.fromJson(Map<String, dynamic> json) {
    return AnswerEntity(answer: json['answer'], key: json['key']);
  }

  Map<String, dynamic> toJson() {
    return {'answer': answer, 'key': key};
  }
}
