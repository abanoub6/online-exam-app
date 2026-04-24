import 'package:injectable/injectable.dart';
import 'package:online_exam_app_v/features/exams/api/exam_api_client/exam_api_client.dart';
import 'package:online_exam_app_v/features/exams/data/data_source/exam_remote_data_source_contract.dart';
import 'package:online_exam_app_v/features/exams/data/model/exam_dto.dart';

@Injectable(as: ExamRemoteDataSourceContract)
class ExamRemoteDataSourceImpl implements ExamRemoteDataSourceContract {
  final ExamApiClient _apiClient;
  const ExamRemoteDataSourceImpl(this._apiClient);

  @override
  Future<List<ExamDto>> getAllExams() async {
    final response = await _apiClient.getAllExams();
    return response.exams ?? [];
  }

  @override
  Future<List<ExamDto>> getExamsBySubject(String subjectId) async {
    final response = await _apiClient.getExamsBySubject(subjectId);
    return response.exams ?? [];
  }
}
