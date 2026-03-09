// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i558;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../dio/dio_interceptor.dart' as _i297;
import '../dio/dio_module.dart' as _i977;
import '../storage/secure_storage_module.dart' as _i391;
import '../storage/token_service.dart' as _i761;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final storageModule = _$StorageModule();
    final dioModule = _$DioModule();
    gh.lazySingleton<_i558.FlutterSecureStorage>(
      () => storageModule.secureStorage(),
    );
    gh.lazySingleton<_i761.TokenService>(
      () => _i761.TokenService(gh<_i558.FlutterSecureStorage>()),
    );
    gh.lazySingleton<_i297.AuthInterceptor>(
      () => _i297.AuthInterceptor(gh<_i761.TokenService>()),
    );
    gh.lazySingleton<_i361.Dio>(
      () => dioModule.dio(gh<_i297.AuthInterceptor>()),
    );
    return this;
  }
}

class _$StorageModule extends _i391.StorageModule {}

class _$DioModule extends _i977.DioModule {}
