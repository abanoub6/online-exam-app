
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam_app_v/core/constants/app_endpoints.dart';

@module
abstract class DioModule {
  @singleton
  Dio get dio => Dio(
    BaseOptions(
      receiveDataWhenStatusError: true,
      baseUrl: AppEndPoints.baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ),
  );
}
