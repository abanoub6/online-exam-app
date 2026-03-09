import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam_app_v/config/storage/token_service.dart';

@lazySingleton
class AuthInterceptor extends Interceptor {
  final TokenService tokenService;

  AuthInterceptor(this.tokenService);

  @override
  void onRequest(options, handler) async {
    final token = await tokenService.getToken();

    if (token != null) {
      options.headers["Authorization"] = "Bearer $token";
    }

    super.onRequest(options, handler);
  }
}
