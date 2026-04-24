import 'package:injectable/injectable.dart';
import 'package:online_exam_app_v/features/results/domain/enties/exam_result_entity.dart';
import 'package:online_exam_app_v/features/results/data/data-source/results_local_data_source.dart';
import 'package:online_exam_app_v/features/results/domain/repo/results_repo.dart';

@Injectable(as: ResultsRepository)
class ResultsRepositoryImpl implements ResultsRepository {
  final ResultsLocalDataSource localDataSource;

  ResultsRepositoryImpl(this.localDataSource);

  @override
  Future<void> saveResult(ExamResultEntity result) {
    return localDataSource.saveResult(result);
  }

  @override
  List<ExamResultEntity> getResults() {
    return localDataSource.getResults();
  }
}
