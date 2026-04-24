import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:online_exam_app_v/features/exams/data/model/exam_dto.dart';

part 'exams_response.g.dart';

@JsonSerializable()
class ExamResponse extends Equatable {
  final String? message;

  @JsonKey(name: 'metadata')
  final PaginationInfo? paginationInfo;

  final List<ExamDto>? exams;

  const ExamResponse({this.message, this.paginationInfo, this.exams});

  factory ExamResponse.fromJson(Map<String, dynamic> json) =>
      _$ExamResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ExamResponseToJson(this);

  @override
  List<Object?> get props => [message, paginationInfo, exams];
}

@JsonSerializable()
class PaginationInfo extends Equatable {
  final int? currentPage;
  final int? numberOfPages;
  final int? limit;

  const PaginationInfo({this.currentPage, this.numberOfPages, this.limit});

  factory PaginationInfo.fromJson(Map<String, dynamic> json) =>
      _$PaginationInfoFromJson(json);

  Map<String, dynamic> toJson() => _$PaginationInfoToJson(this);

  @override
  List<Object?> get props => [currentPage, numberOfPages, limit];
}
