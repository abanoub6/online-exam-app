import 'package:json_annotation/json_annotation.dart';

part 'subject_dto.g.dart';

@JsonSerializable()
class SubjectDto {
  @JsonKey(name: '_id')
  final String id;

  final String name;
  final String? icon;

  @JsonKey(name: 'createdAt')
  final DateTime? createdAt;

  SubjectDto({required this.id, required this.name, this.icon, this.createdAt});

  factory SubjectDto.fromJson(Map<String, dynamic> json) =>
      _$SubjectDtoFromJson(json);

  Map<String, dynamic> toJson() => _$SubjectDtoToJson(this);
}
