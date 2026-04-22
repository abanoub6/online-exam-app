import 'package:equatable/equatable.dart';
import 'package:online_exam_app_v/features/exams/data/model/exam_dto.dart';

class ExamResponse extends Equatable {
  final String message;
  final PaginationInfo paginationInfo;
  final List<ExamDto> exams;

  const ExamResponse({
    required this.message,
    required this.paginationInfo,
    required this.exams,
  });

  factory ExamResponse.fromJson(Map<String, dynamic> json) => ExamResponse(
    message: json['message'] ?? '',
    paginationInfo: PaginationInfo.fromJson(json['metadata'] ?? {}),
    exams: (json['exams'] as List<dynamic>? ?? [])
        .map((e) => ExamDto.fromJson(e))
        .toList(),
  );

  @override
  List<Object?> get props => [message, paginationInfo, exams];
}

class PaginationInfo extends Equatable {
  final int currentPage;
  final int numberOfPages;
  final int limit;

  const PaginationInfo({
    required this.currentPage,
    required this.numberOfPages,
    required this.limit,
  });

  factory PaginationInfo.fromJson(Map<String, dynamic> json) => PaginationInfo(
    currentPage: json['currentPage'] ?? 1,
    numberOfPages: json['numberOfPages'] ?? 1,
    limit: json['limit'] ?? 40,
  );

  @override
  List<Object?> get props => [currentPage, numberOfPages, limit];
}
