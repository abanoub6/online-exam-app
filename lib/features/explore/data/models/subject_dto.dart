import 'package:json_annotation/json_annotation.dart';

part 'subject_dto.g.dart';

@JsonSerializable()
class SubjectDto {
  @JsonKey(name: '_id')
  String? id;
  String? name;
  String? icon;
  String? createdAt;

  SubjectDto(this.id, this.name, this.icon, this.createdAt);

  factory SubjectDto.fromJson(Map<String, dynamic> json) =>
      _$SubjectDtoFromJson(json);
}
