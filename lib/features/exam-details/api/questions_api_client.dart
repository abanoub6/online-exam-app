import 'package:dio/dio.dart';
import 'package:online_exam_app_v/core/constants/app_api_param.dart';
import 'package:online_exam_app_v/core/constants/app_endpoints.dart';
import 'package:online_exam_app_v/features/exam-details/data/models/questions_response.dart';
import 'package:retrofit/retrofit.dart';
import 'package:injectable/injectable.dart';

part 'questions_api_client.g.dart';

@lazySingleton
@RestApi()
abstract class QuestionsApiClient {
  @factoryMethod
  factory QuestionsApiClient(Dio dio) = _QuestionsApiClient;

  @GET(AppEndpoints.questions)
  Future<QuestionsResponse> getQuestionsOnExam(
    @Query(AppApiParam.exam) String examId,
  );
}
