import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam_app_v/core/constants/app_endpoints.dart';
import 'package:online_exam_app_v/features/exams/data/model/responces/exams_response.dart';
import 'package:retrofit/retrofit.dart';

part 'exam_api_client.g.dart';

@lazySingleton
@RestApi()
abstract class ExamApiClient {
  @factoryMethod
  factory ExamApiClient(Dio dio) = _ExamApiClient;

  @GET(AppEndpoints.getAllExams)
  Future<ExamResponse> getAllExams();

  @GET(AppEndpoints.getAllExams)
  Future<ExamResponse> getExamsBySubject(@Query("subject") String subjectId);
}
