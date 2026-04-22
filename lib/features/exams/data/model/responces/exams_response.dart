import 'package:json_annotation/json_annotation.dart';
import 'package:online_exam_app_v/features/exams/data/model/exam_dto.dart';

part 'exams_response.g.dart';

@JsonSerializable()
class ExamResponse {
  @JsonKey(name: "message")
  String? message;

  @JsonKey(name: "metadata")
  PaginationInfo? paginationInfo;

  @JsonKey(name: "exams")
  List<ExamDto>? exams;

  ExamResponse({
    this.message,
    this.paginationInfo,
    this.exams,
  });

  factory ExamResponse.fromJson(Map<String, dynamic> json) =>
      _$ExamResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ExamResponseToJson(this);
}

@JsonSerializable()
class PaginationInfo {
  @JsonKey(name: "currentPage")
  int? currentPage;

  @JsonKey(name: "numberOfPages")
  int? numberOfPages;

  @JsonKey(name: "limit")
  int? limit;

  PaginationInfo({
    this.currentPage,
    this.numberOfPages,
    this.limit,
  });

  factory PaginationInfo.fromJson(Map<String, dynamic> json) =>
      _$PaginationInfoFromJson(json);

  Map<String, dynamic> toJson() => _$PaginationInfoToJson(this);
}