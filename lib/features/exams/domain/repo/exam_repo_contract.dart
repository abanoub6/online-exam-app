import 'package:online_exam_app_v/config/base_responce/base_response.dart';
import 'package:online_exam_app_v/features/exams/domain/models/exam_entity.dart';

abstract interface class ExamRepoContract {
  Future<BaseResponse<List<ExamEntity>>> getAllExams();
  Future<BaseResponse<List<ExamEntity>>> getExamsBySubject(String subjectId);
}
