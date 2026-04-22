import 'package:injectable/injectable.dart';
import 'package:online_exam_app_v/config/base_responce/base_response.dart';
import 'package:online_exam_app_v/features/exams/domain/models/exam_entity.dart';
import 'package:online_exam_app_v/features/exams/domain/repo/exam_repo_contract.dart';

@injectable
class GetAllExamsUseCase {
  GetAllExamsUseCase(this.examRepoContract);
  final ExamRepoContract examRepoContract;

  Future<BaseResponse<List<ExamEntity>>> call() async {
    return examRepoContract.getAllExams();
  }
}
