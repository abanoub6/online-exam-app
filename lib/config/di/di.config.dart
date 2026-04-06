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

import '../../features/login/api/data_sources/login_remote_data_source_imp.dart'
    as _i211;
import '../../features/login/api/login_api_client/login_api_client.dart'
    as _i315;
import '../../features/login/data/data_sources/login_remote_data_source_contract.dart'
    as _i159;
import '../../features/login/data/repo/login_repo_imp.dart' as _i185;
import '../../features/login/domain/repo/login_repo_contract.dart' as _i180;
import '../../features/login/domain/use_cases/login_use_case.dart' as _i191;
import '../../features/login/domain/use_cases/remember_me.dart' as _i844;
import '../../features/login/presentation/view_model/cubit/login_view_model.dart'
    as _i705;
import '../dio/dio_interceptor.dart' as _i297;
import '../dio/dio_module.dart' as _i977;
import '../storage/secure_storage_module.dart' as _i391;

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
    gh.lazySingleton<_i297.AuthInterceptor>(
      () => _i297.AuthInterceptor(gh<_i558.FlutterSecureStorage>()),
    );
    gh.lazySingleton<_i361.Dio>(
      () => dioModule.dio(gh<_i297.AuthInterceptor>()),
    );
    gh.factory<_i315.LoginApiClient>(
      () => _i315.LoginApiClient(gh<_i361.Dio>()),
    );
    gh.factory<_i159.LoginRemoteDataSourceContract>(
      () => _i211.LoginRemoteDataSourceImp(gh<_i315.LoginApiClient>()),
    );
    gh.factory<_i180.LoginRepoContract>(
      () => _i185.LoginRepoImp(
        gh<_i159.LoginRemoteDataSourceContract>(),
        gh<_i558.FlutterSecureStorage>(),
      ),
    );
    gh.lazySingleton<_i844.RememberMeUseCase>(
      () => _i844.RememberMeUseCase(
        loginRepoContract: gh<_i180.LoginRepoContract>(),
      ),
    );
    gh.lazySingleton<_i191.LoginUseCase>(
      () => _i191.LoginUseCase(gh<_i180.LoginRepoContract>()),
    );
    gh.factory<_i705.LoginViewModel>(
      () => _i705.LoginViewModel(
        gh<_i191.LoginUseCase>(),
        rememberMeUseCase: gh<_i844.RememberMeUseCase>(),
      ),
    );
    return this;
  }
}

class _$StorageModule extends _i391.StorageModule {}

class _$DioModule extends _i977.DioModule {}
