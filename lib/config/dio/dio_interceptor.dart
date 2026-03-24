import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam_app_v/core/constants/app_api_param.dart';

@lazySingleton
class AuthInterceptor extends Interceptor {
  final FlutterSecureStorage secureStorage;

  AuthInterceptor(this.secureStorage);

  @override
  void onRequest(options, handler) async {
    final token = await secureStorage.read(key: AppApiParam.token);

    if (token != null) {
      options.headers["Authorization"] = "Bearer $token";
    }

    super.onRequest(options, handler);
  }
}
