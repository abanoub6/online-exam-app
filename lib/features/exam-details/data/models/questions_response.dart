import 'package:json_annotation/json_annotation.dart';
import 'question_dto.dart';

part 'questions_response.g.dart';

@JsonSerializable()
class QuestionsResponse {
  final String message;
  final List<QuestionDto> questions;

  QuestionsResponse({required this.message, required this.questions});

  factory QuestionsResponse.fromJson(Map<String, dynamic> json) =>
      _$QuestionsResponseFromJson(json);
  Map<String, dynamic> toJson() => _$QuestionsResponseToJson(this);
}
