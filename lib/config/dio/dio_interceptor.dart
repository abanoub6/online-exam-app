import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam_app_v/config/services/navigation_service.dart';
import 'package:online_exam_app_v/core/constants/app_api_param.dart';
import 'package:online_exam_app_v/core/constants/app_endpoints.dart';
import 'package:online_exam_app_v/features/login/presentation/screens/login_screen.dart';

@lazySingleton
class AuthInterceptor extends Interceptor {
  final FlutterSecureStorage secureStorage;

  static const _tokenSavingEndpoints = [
    AppEndpoints.signIn,
    AppEndpoints.signUp,
    // AppEndpoints.changePassword,
  ];

  AuthInterceptor(this.secureStorage);

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await secureStorage.read(key: AppApiParam.token);

    if (token != null) {
      options.headers["token"] = token;
    }

    handler.next(options);
  }

  @override
  Future<void> onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) async {
    final path = response.requestOptions.path;
    final shouldSaveToken = _tokenSavingEndpoints.any(
      (endpoint) => path.contains(endpoint),
    );

    if (shouldSaveToken &&
        response.data is Map &&
        response.data["token"] != null) {
      await secureStorage.write(
        key: AppApiParam.token,
        value: response.data["token"],
      );
    }

    handler.next(response);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    if (err.response?.statusCode == 401) {
      await secureStorage.delete(key: AppApiParam.token);
      await secureStorage.delete(key: AppApiParam.rememberMe);
      NavigationService.navigateTo(LoginScreen.routeName);
    }

    handler.next(err);
  }
}
