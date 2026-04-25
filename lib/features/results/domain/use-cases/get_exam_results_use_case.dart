import 'package:injectable/injectable.dart';
import 'package:online_exam_app_v/features/results/domain/enties/exam_result_entity.dart';
import 'package:online_exam_app_v/features/results/domain/repo/results_repo.dart';

@injectable
class GetExamResultsUseCase {
  final ResultsRepository repository;

  GetExamResultsUseCase(this.repository);

  List<ExamResultEntity> call() {
    return repository.getResults();
  }
}
