import 'package:json_annotation/json_annotation.dart';
import 'package:online_exam_app_v/features/exam-details/domain/entities/answer_entity.dart';

part 'answer_dto.g.dart';

@JsonSerializable()
class AnswerDto {
  final String answer;
  final String key;

  AnswerDto({required this.answer, required this.key});

  factory AnswerDto.fromJson(Map<String, dynamic> json) =>
      _$AnswerDtoFromJson(json);

  Map<String, dynamic> toJson() => _$AnswerDtoToJson(this);

  // toEntity()
  AnswerEntity toEntity() => AnswerEntity(answer: answer, key: key);
}
