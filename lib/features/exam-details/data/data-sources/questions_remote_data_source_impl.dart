import 'package:injectable/injectable.dart';
import 'package:online_exam_app_v/config/base_responce/base_response.dart';
import 'package:online_exam_app_v/core/network/api_error_handler.dart';
import 'package:online_exam_app_v/features/exam-details/api/questions_api_client.dart';
import 'package:online_exam_app_v/features/exam-details/data/data-sources/questions_remote_data_source_contract.dart';
import 'package:online_exam_app_v/features/exam-details/data/models/question_dto.dart';

@Injectable(as: QuestionsRemoteDataSourceContract)
class QuestionsRemoteDataSourceImpl
    implements QuestionsRemoteDataSourceContract {
  final QuestionsApiClient questionsApiClient;

  QuestionsRemoteDataSourceImpl(this.questionsApiClient);

  @override
  Future<BaseResponse<List<QuestionDto>>> getQuestionsOnExam(
    String examId,
  ) async {
    try {
      final response = await questionsApiClient.getQuestionsOnExam(examId);
      print(">>>>>>>>>> test sucsses >>>>>>>>>>>>>>>>>.");
      print(response.message);
      return SuccessBaseResponse<List<QuestionDto>>(data: response.questions);
    } catch (e) {
      print(">>>>>>>>>>>>> test filure>>>>>>>>>>>>>>.");

      print(e);
      return ErrorBaseResponse<List<QuestionDto>>(
        errorMessage: ApiErrorHandler.getErrorMessage(e),
      );
    }
  }
}
