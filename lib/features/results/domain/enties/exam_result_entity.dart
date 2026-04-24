import 'package:flutter/material.dart';
import 'package:online_exam_app_v/core/constants/app_strings.dart';
import 'package:online_exam_app_v/features/results/domain/enties/question_snap_shot_entity.dart';

@immutable
class ExamResultEntity {
  final String examId;
  final String examTitle;

  final int correctAnswers;
  final int totalQuestions;
  final double percentage;

  final List<QuestionSnapshotEntity> questions;

  const ExamResultEntity({
    required this.examId,
    required this.examTitle,
    required this.correctAnswers,
    required this.totalQuestions,
    required this.percentage,
    required this.questions,
  });

  factory ExamResultEntity.fromJson(Map<String, dynamic> json) {
    return ExamResultEntity(
      examId: json[AppStrings.examId],
      examTitle: json[AppStrings.examTitle],
      correctAnswers: json[AppStrings.correctAnswers],
      totalQuestions: json[AppStrings.totalQuestions],
      percentage: (json[AppStrings.percentage] as num).toDouble(),
      questions: (json[AppStrings.questions] as List)
          .map(
            (e) =>
                QuestionSnapshotEntity.fromJson(Map<String, dynamic>.from(e)),
          )
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      AppStrings.examId: examId,
      AppStrings.examTitle: examTitle,
      AppStrings.correctAnswers: correctAnswers,
      AppStrings.totalQuestions: totalQuestions,
      AppStrings.percentage: percentage,
      AppStrings.questions: questions.map((e) => e.toJson()).toList(),
    };
  }
}
