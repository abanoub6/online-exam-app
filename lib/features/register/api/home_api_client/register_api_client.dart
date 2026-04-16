import 'package:dio/dio.dart';
import 'package:online_exam_app_v/core/constants/app_endpoints.dart';
import 'package:online_exam_app_v/features/register/data/models/register_request.dart';
import 'package:online_exam_app_v/features/register/data/models/register_response.dart';
import 'package:retrofit/retrofit.dart';
import 'package:injectable/injectable.dart';

part 'register_api_client.g.dart';

@injectable
@RestApi()
abstract class RegisterApiClient {
  @factoryMethod
  factory RegisterApiClient(Dio dio) = _RegisterApiClient;

  @POST(AppEndpoints.signUp)
  Future<RegisterResponse> register(@Body() RegisterRequest registerRequest);
}
