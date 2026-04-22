import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam_app_v/core/constants/app_endpoints.dart';
import 'package:online_exam_app_v/features/explore/data/models/response/subject_response_model.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

part 'explor_api_client.g.dart';

@injectable
@RestApi(baseUrl: AppEndpoints.baseUrl)
abstract class ExplorApiClient {
  @factoryMethod
  factory ExplorApiClient(Dio dio) = _ExplorApiClient;

  @GET(AppEndpoints.subjects)
  Future<SubjectResponseModel> getSubjectList();
}
