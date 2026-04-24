import 'package:injectable/injectable.dart';
import 'package:online_exam_app_v/config/storage/results_hive_service.dart';
import 'package:online_exam_app_v/features/results/domain/enties/exam_result_entity.dart';
import 'package:online_exam_app_v/features/results/data/data-source/results_local_data_source.dart';

@Injectable(as: ResultsLocalDataSource)
class ResultsLocalDataSourceImpl implements ResultsLocalDataSource {
  final ResultsHiveService hiveService;

  ResultsLocalDataSourceImpl(this.hiveService);

  @override
  Future<void> saveResult(ExamResultEntity result) {
    return hiveService.saveResult(result);
  }

  @override
  List<ExamResultEntity> getResults() {
    return hiveService.getResults();
  }
}
