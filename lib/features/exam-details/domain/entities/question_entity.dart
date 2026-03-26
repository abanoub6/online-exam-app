import 'package:online_exam_app_v/features/exam-details/domain/entities/answer_entity.dart';

class QuestionEntity {
  final String id;
  final String question;
  final List<AnswerEntity> answers;
  final String correctAnswerKey;
  final String type;
  final DateTime createdAt;

  QuestionEntity({
    required this.id,
    required this.question,
    required this.answers,
    required this.correctAnswerKey,
    required this.type,
    required this.createdAt,
  });
}
