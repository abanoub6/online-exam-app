import 'package:json_annotation/json_annotation.dart';
import 'package:online_exam_app_v/features/exam-details/data/models/exam_dto.dart';
import 'package:online_exam_app_v/features/exam-details/data/models/subject_dto.dart';
import 'package:online_exam_app_v/features/exam-details/domain/entities/question_entity.dart';
import 'answer_dto.dart';

part 'question_dto.g.dart';

@JsonSerializable()
class QuestionDto {
  final List<AnswerDto> answers;
  final String type;
  @JsonKey(name: '_id')
  final String id;
  final String question;
  final String correct;
  final SubjectDto? subject;
  final ExamDto? exam;
  final DateTime? createdAt;

  QuestionDto({
    required this.answers,
    required this.type,
    required this.id,
    required this.question,
    required this.correct,
    this.subject,
    this.exam,
    this.createdAt,
  });

  factory QuestionDto.fromJson(Map<String, dynamic> json) =>
      _$QuestionDtoFromJson(json);
  Map<String, dynamic> toJson() => _$QuestionDtoToJson(this);

  QuestionEntity toEntity() => QuestionEntity(
    id: id,
    question: question,
    answers: answers.map((e) => e.toEntity()).toList(),
    correctAnswerKey: correct,
    type: type,
    exam: exam,
    createdAt: createdAt ?? DateTime.now(),
  );
}
