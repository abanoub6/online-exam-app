import 'package:injectable/injectable.dart';
import 'package:online_exam_app_v/config/base_responce/base_response.dart';
import 'package:online_exam_app_v/features/exam-details/domain/entities/question_entity.dart';
import 'package:online_exam_app_v/features/exam-details/domain/repo/questions_repository_contract.dart';

@injectable
class GetQuestionsOnExamUseCase {
  final QuestionsRepositoryContract repository;

  GetQuestionsOnExamUseCase(this.repository);

  Future<BaseResponse<List<QuestionEntity>>> call(String examId) {
    return repository.getQuestionsOnExam(examId);
  }
}
