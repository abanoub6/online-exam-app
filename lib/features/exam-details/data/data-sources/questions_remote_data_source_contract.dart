import 'package:online_exam_app_v/config/base_responce/base_response.dart';
import 'package:online_exam_app_v/features/exam-details/data/models/question_dto.dart';

abstract interface class QuestionsRemoteDataSourceContract {
  Future<BaseResponse<List<QuestionDto>>> getQuestionsOnExam(String examId);
}
