import 'package:online_exam_app_v/features/results/domain/enties/exam_result_entity.dart';

abstract interface class ResultsRepository {
  Future<void> saveResult(ExamResultEntity result);
  List<ExamResultEntity> getResults();
}
