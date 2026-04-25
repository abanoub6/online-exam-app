import 'package:injectable/injectable.dart';
import 'package:online_exam_app_v/features/results/domain/enties/exam_result_entity.dart';
import 'package:online_exam_app_v/features/results/domain/repo/results_repo.dart';

@injectable
class SaveExamResultUseCase {
  final ResultsRepository repository;

  SaveExamResultUseCase(this.repository);

  Future<void> call(ExamResultEntity result) {
    return repository.saveResult(result);
  }
}
