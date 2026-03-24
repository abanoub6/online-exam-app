import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:online_exam_app_v/config/base_responce/base_responce.dart';
import 'package:online_exam_app_v/core/constants/app_endpoints.dart';
import 'package:online_exam_app_v/feature/login/data/models/login_request.dart';
import 'package:online_exam_app_v/feature/login/data/models/login_response_model.dart';
import 'package:retrofit/retrofit.dart';

part 'login_api_client.g.dart';

@injectable
@RestApi()
abstract class LoginApiClient {
  @factoryMethod
  factory LoginApiClient(Dio dio) = _LoginApiClient;

  @POST(AppEndpoints.signIn)
  Future<LoginResponseModel> login(@Body() LoginRequest loginRequest);
  
}
