import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:online_exam_app_v/features/exams/domain/models/exam_entity.dart';

part 'exam_dto.g.dart';

@JsonSerializable()
class ExamDto extends Equatable {
  @JsonKey(name: '_id')
  final String? id;
  final String? title;
  final int? duration;
  final String? subject;
  final int? numberOfQuestions;
  final bool? active;
  final String? createdAt;

  const ExamDto({
    this.id,
    this.title,
    this.duration,
    this.subject,
    this.numberOfQuestions,
    this.active,
    this.createdAt,
  });

  factory ExamDto.fromJson(Map<String, dynamic> json) =>
      _$ExamDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ExamDtoToJson(this);

  ExamEntity toEntity() => ExamEntity(
    id: id ?? '',
    title: title ?? '',
    duration: duration ?? 0,
    subject: subject ?? '',
    numberOfQuestions: numberOfQuestions ?? 0,
    active: active ?? false,
    createdAt: createdAt ?? '',
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
