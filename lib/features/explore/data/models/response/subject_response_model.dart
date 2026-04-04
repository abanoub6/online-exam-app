import 'package:json_annotation/json_annotation.dart';
import 'package:online_exam_app_v/features/explore/data/models/subject_dto.dart';

part 'subject_response_model.g.dart';

@JsonSerializable()
class SubjectResponseModel {
  String? message;
  List<SubjectDto?>? subjects;

  SubjectResponseModel(this.message, this.subjects);

  factory SubjectResponseModel.fromJson(Map<String, dynamic> json) =>
      _$SubjectResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$SubjectResponseModelToJson(this);
}
