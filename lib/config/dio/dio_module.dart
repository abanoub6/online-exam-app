import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam_app_v/config/dio/dio_interceptor.dart';
import 'package:online_exam_app_v/core/constants/app_endpoints.dart';

@module
abstract class DioModule {
  @lazySingleton
  Dio dio(AuthInterceptor interceptor) {
    final dio = Dio(
      BaseOptions(
        receiveDataWhenStatusError: true,
        baseUrl: AppEndpoints.baseUrl,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
      ),
    );

    dio.interceptors.add(interceptor);

    return dio;
  }
}
