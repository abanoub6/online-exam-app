import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam_app_v/config/base_responce/base_response.dart';
import 'package:online_exam_app_v/core/network/api_error_handler.dart';
import 'package:online_exam_app_v/features/exams/data/data_source/exam_remote_data_source_contract.dart';
import 'package:online_exam_app_v/features/exams/domain/models/exam_entity.dart';
import 'package:online_exam_app_v/features/exams/domain/repo/exam_repo_contract.dart';

@Injectable(as: ExamRepoContract)
class ExamRepoImpl implements ExamRepoContract {
  final ExamRemoteDataSourceContract _dataSource;
  const ExamRepoImpl(this._dataSource);

  @override
  Future<BaseResponse<List<ExamEntity>>> getAllExams() async {
    try {
      final exams = await _dataSource.getAllExams();
      return SuccessBaseResponse(
        data: exams.map((dto) => dto.toEntity()).toList(),
      );
    } catch (e) {
      return ErrorBaseResponse(
        errorMessage: ApiErrorHandler.getErrorMessage(e),
      );
    }
  }

  @override
  Future<BaseResponse<List<ExamEntity>>> getExamsBySubject(
    String subjectId,
  ) async {
    try {
      final exams = await _dataSource.getExamsBySubject(subjectId);
      return SuccessBaseResponse(
        data: exams.map((dto) => dto.toEntity()).toList(),
      );
    } catch (e) {
      return ErrorBaseResponse(
        errorMessage: ApiErrorHandler.getErrorMessage(e),
      );
    }
  }
}
