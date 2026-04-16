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
    // final token = await secureStorage.read(key: AppApiParam.token);
    final token =
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY5ZGFmY2Q1MDRkYTBkNGNmNTU2OTFjZiIsInJvbGUiOiJ1c2VyIiwiaWF0IjoxNzc1OTU5MjUzfQ.nIdRCRYf1qY1uIVpmBlXpH6K1DSIC2Jhar1bWn4VWMQ";

    if (token != null) {
      options.headers["token"] = token;
    }

    super.onRequest(options, handler);
  }
}
