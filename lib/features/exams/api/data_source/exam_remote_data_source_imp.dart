import 'package:injectable/injectable.dart';
import 'package:online_exam_app_v/features/exams/api/exam_api_client/exam_api_client.dart';
import 'package:online_exam_app_v/features/exams/data/data_source/exam_remote_data_source_contract.dart';
import 'package:online_exam_app_v/features/exams/data/model/exam_dto.dart';

@Injectable(as: ExamRemoteDataSourceContract)
class ExamRemoteDataSourceImp implements ExamRemoteDataSourceContract {
  ExamRemoteDataSourceImp(this.examApiClient);
  final ExamApiClient examApiClient;
  @override
  Future<List<ExamDto>> getAllExams() {
    return Future.value(<ExamDto>[]);
  }
}
