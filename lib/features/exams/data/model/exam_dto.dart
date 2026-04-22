import 'package:equatable/equatable.dart';
import 'package:online_exam_app_v/features/exams/domain/models/exam_entity.dart';

class ExamDto extends Equatable {
  final String id;
  final String title;
  final int duration;
  final String subject;
  final int numberOfQuestions;
  final bool active;
  final String createdAt;

  const ExamDto({
    required this.id,
    required this.title,
    required this.duration,
    required this.subject,
    required this.numberOfQuestions,
    required this.active,
    required this.createdAt,
  });

  factory ExamDto.fromJson(Map<String, dynamic> json) => ExamDto(
    id: json['_id'] ?? '',
    title: json['title'] ?? '',
    duration: json['duration'] ?? 0,
    subject: json['subject'] ?? '',
    numberOfQuestions: json['numberOfQuestions'] ?? 0,
    active: json['active'] ?? false,
    createdAt: json['createdAt'] ?? '',
  );

  ExamEntity toEntity() => ExamEntity(
    id: id,
    title: title,
    duration: duration,
    subject: subject,
    numberOfQuestions: numberOfQuestions,
    active: active,
    createdAt: createdAt,
  );

  @override
  List<Object?> get props => [
    id,
    title,
    duration,
    subject,
    numberOfQuestions,
    active,
    createdAt,
  ];
}
