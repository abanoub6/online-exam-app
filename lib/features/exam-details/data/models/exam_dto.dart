import 'package:json_annotation/json_annotation.dart';

part 'exam_dto.g.dart';

@JsonSerializable()
class ExamDto {
  @JsonKey(name: '_id')
  final String id;

  final String title;
  final int duration;
  final String subject;
  final int numberOfQuestions;
  final bool active;

  @JsonKey(name: 'createdAt')
  final DateTime? createdAt;

  ExamDto({
    required this.id,
    required this.title,
    required this.duration,
    required this.subject,
    required this.numberOfQuestions,
    required this.active,
    this.createdAt,
  });

  factory ExamDto.fromJson(Map<String, dynamic> json) =>
      _$ExamDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ExamDtoToJson(this);
}
