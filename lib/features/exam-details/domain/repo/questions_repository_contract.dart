import 'package:online_exam_app_v/config/base_responce/base_response.dart';
import 'package:online_exam_app_v/features/exam-details/domain/entities/question_entity.dart';

abstract class QuestionsRepositoryContract {
  Future<BaseResponse<List<QuestionEntity>>> getQuestionsOnExam(String examId);
}
