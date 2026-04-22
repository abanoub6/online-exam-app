import 'package:online_exam_app_v/config/base_responce/base_response.dart';
import 'package:online_exam_app_v/features/exams/data/model/exam_dto.dart';

abstract class ExamRemoteDataSourceContract {
  Future<BaseResponse<List<ExamDto>>> getAllExams();
}
