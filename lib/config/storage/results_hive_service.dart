import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam_app_v/features/results/domain/enties/exam_result_entity.dart';

@injectable
class ResultsHiveService {
  Future<void> saveResult(ExamResultEntity result) async {
    final box = Hive.box("exam_results_box");

    await box.add(result.toJson());
  }

  List<ExamResultEntity> getResults() {
    final box = Hive.box("exam_results_box");

    return box.values.map((e) {
      return ExamResultEntity.fromJson(Map<String, dynamic>.from(e));
    }).toList();
  }

  Future<void> clearResults() async {
    final box = Hive.box("exam_results_box");
    await box.clear();
  }
}
