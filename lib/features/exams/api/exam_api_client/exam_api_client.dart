import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam_app_v/core/constants/app_endpoints.dart';
import 'package:online_exam_app_v/features/exams/data/model/exam_dto.dart';
import 'package:online_exam_app_v/features/exams/data/model/responces/exams_response.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

part 'exam_api_client.g.dart';
@injectable
@RestApi()
abstract class ExamApiClient {
  @factoryMethod
  factory ExamApiClient(Dio dio) = _ExamApiClient;


  @GET(AppEndpoints.getAllExams)
  Future<ExamResponse> getAllExams(@Header("token") String token);
}
