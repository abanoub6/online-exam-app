import 'package:online_exam_app_v/core/constants/app_strings.dart';
import 'package:online_exam_app_v/features/exam-details/domain/entities/answer_entity.dart';

class QuestionSnapshotEntity {
  final String questionId;
  final String question;
  final List<AnswerEntity> answers;
  final String correctAnswerKey;
  final String? selectedAnswer;

  const QuestionSnapshotEntity({
    required this.questionId,
    required this.question,
    required this.answers,
    required this.correctAnswerKey,
    required this.selectedAnswer,
  });

  factory QuestionSnapshotEntity.fromJson(Map<String, dynamic> json) {
    return QuestionSnapshotEntity(
      questionId: json[AppStrings.questionId],
      question: json[AppStrings.question],
      correctAnswerKey: json[AppStrings.correctAnswerKey],
      selectedAnswer: json[AppStrings.selectedAnswer],
      answers: (json[AppStrings.answers] as List)
          .map((e) => AnswerEntity.fromJson(Map<String, dynamic>.from(e)))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      AppStrings.questionId: questionId,
      AppStrings.question: question,
      AppStrings.correctAnswerKey: correctAnswerKey,
      AppStrings.selectedAnswer: selectedAnswer,
      AppStrings.answers: answers.map((e) => e.toJson()).toList(),
    };
  }
}
