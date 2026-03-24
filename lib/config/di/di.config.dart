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

import '../../feature/login/api/data_source/login_remote_data_source_imp.dart'
    as _i981;
import '../../feature/login/api/login_api_client/login_api_client.dart'
    as _i779;
import '../../feature/login/data/datasources/login_remote_data_source_contract.dart'
    as _i385;
import '../../feature/login/data/repositories/login_repo_imp.dart' as _i1003;
import '../../feature/login/domain/repositories/login_repo_contract.dart'
    as _i408;
import '../../feature/login/domain/usecases/login_use_case.dart' as _i91;
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
    gh.factory<_i779.LoginApiClient>(
      () => _i779.LoginApiClient(gh<_i361.Dio>()),
    );
    gh.factory<_i385.LoginRemoteDataSourceContract>(
      () => _i981.LoginRemoteDataSourceImp(gh<_i779.LoginApiClient>()),
    );
    gh.factory<_i408.LoginRepoContract>(
      () => _i1003.LoginRepoImp(gh<_i385.LoginRemoteDataSourceContract>()),
    );
    gh.factory<_i91.LoginUseCase>(
      () => _i91.LoginUseCase(gh<_i408.LoginRepoContract>()),
    );
    return this;
  }
}

class _$StorageModule extends _i391.StorageModule {}

class _$DioModule extends _i977.DioModule {}
