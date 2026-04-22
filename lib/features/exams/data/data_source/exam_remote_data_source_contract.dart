import 'package:online_exam_app_v/features/exams/data/model/exam_dto.dart';

abstract interface class ExamRemoteDataSourceContract {
  Future<List<ExamDto>> getAllExams();
  Future<List<ExamDto>> getExamsBySubject(String subjectId);
}
