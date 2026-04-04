// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:flutter/material.dart' as _i409;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i558;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../features/explore/api/data_sources/explor_remote_data_source_impl.dart'
    as _i394;
import '../../features/explore/api/explor_api_client/explor_api_client.dart'
    as _i734;
import '../../features/explore/data/data_sources/explor_remote_data_source_contract.dart'
    as _i320;
import '../../features/explore/data/repo/explor_repo_impl.dart' as _i1068;
import '../../features/explore/domain/repo/explor_repo_contract.dart' as _i692;
import '../../features/explore/domain/use_cases/get_subjects_use_case.dart'
    as _i593;
import '../../features/explore/presentation/view_model/cubit/explor_view_model.dart'
    as _i241;
import '../../features/forgot_password/data/api/api_service.dart' as _i793;
import '../../features/forgot_password/data/repo/forget_password_repo_impl.dart'
    as _i320;
import '../../features/forgot_password/domain/repo/forget_password_repo_contract.dart'
    as _i511;
import '../../features/forgot_password/domain/use_cases/forgot_password_use_case.dart'
    as _i597;
import '../../features/forgot_password/domain/use_cases/reset_password_use_case.dart'
    as _i578;
import '../../features/forgot_password/domain/use_cases/verify_reset_code_use_case.dart'
    as _i717;
import '../../features/forgot_password/presentation/view_model/cubits/forgot_password_view_model.dart'
    as _i1024;
import '../../features/register/api/data_source/register_remote_data_source_impl.dart'
    as _i845;
import '../../features/register/api/home_api_client/register_api_client.dart'
    as _i410;
import '../../features/register/data/data_sources/register_remote_data_source_contract.dart'
    as _i684;
import '../../features/register/data/repo/register_repository_impl.dart'
    as _i921;
import '../../features/register/domain/repo/register_repository_contract.dart'
    as _i210;
import '../../features/register/domain/use_cases/register_usecase.dart'
    as _i679;
import '../../features/register/presentation/screens/register_screen.dart'
    as _i502;
import '../../features/register/presentation/view_model/cubit/register_view_model.dart'
    as _i166;
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
    gh.factory<_i502.RegisterScreen>(
      () => _i502.RegisterScreen(key: gh<_i409.Key>()),
    );
    gh.lazySingleton<_i297.AuthInterceptor>(
      () => _i297.AuthInterceptor(gh<_i558.FlutterSecureStorage>()),
    );
    gh.lazySingleton<_i361.Dio>(
      () => dioModule.dio(gh<_i297.AuthInterceptor>()),
    );
    gh.factory<_i734.ExplorApiClient>(
      () => _i734.ExplorApiClient(gh<_i361.Dio>()),
    );
    gh.factory<_i793.AuthApiService>(
      () => _i793.AuthApiService(gh<_i361.Dio>()),
    );
    gh.factory<_i410.RegisterApiClient>(
      () => _i410.RegisterApiClient(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i511.ForgetPasswordRepoContract>(
      () => _i320.ForgetPasswordRepoImpl(gh<_i793.AuthApiService>()),
    );
    gh.lazySingleton<_i597.ForgotPasswordUseCase>(
      () => _i597.ForgotPasswordUseCase(gh<_i511.ForgetPasswordRepoContract>()),
    );
    gh.lazySingleton<_i578.ResetPasswordUseCase>(
      () => _i578.ResetPasswordUseCase(gh<_i511.ForgetPasswordRepoContract>()),
    );
    gh.lazySingleton<_i717.VerifyResetCodeUseCase>(
      () =>
          _i717.VerifyResetCodeUseCase(gh<_i511.ForgetPasswordRepoContract>()),
    );
    gh.factory<_i1024.ForgotPasswordViewModel>(
      () => _i1024.ForgotPasswordViewModel(
        gh<_i597.ForgotPasswordUseCase>(),
        gh<_i717.VerifyResetCodeUseCase>(),
        gh<_i578.ResetPasswordUseCase>(),
      ),
    );
    gh.factory<_i684.RegisterRemoteDataSourceContract>(
      () => _i845.RegisterRemoteDataSourceImpl(gh<_i410.RegisterApiClient>()),
    );
    gh.lazySingleton<_i320.ExplorRemoteDataSourceContract>(
      () => _i394.ExplorRemoteDataSourceImpl(gh<_i734.ExplorApiClient>()),
    );
    gh.factory<_i210.RegisterRepositoryContract>(
      () => _i921.AuthRepositoryImpl(
        gh<_i684.RegisterRemoteDataSourceContract>(),
      ),
    );
    gh.lazySingleton<_i692.ExplorRepoContract>(
      () => _i1068.ExplorRepoImpl(gh<_i320.ExplorRemoteDataSourceContract>()),
    );
    gh.factory<_i593.GetSubjectsUseCase>(
      () => _i593.GetSubjectsUseCase(gh<_i692.ExplorRepoContract>()),
    );
    gh.factory<_i679.RegisterUseCase>(
      () => _i679.RegisterUseCase(gh<_i210.RegisterRepositoryContract>()),
    );
    gh.factory<_i241.ExplorViewModel>(
      () => _i241.ExplorViewModel(gh<_i593.GetSubjectsUseCase>()),
    );
    gh.singleton<_i166.RegisterViewModel>(
      () => _i166.RegisterViewModel(gh<_i679.RegisterUseCase>()),
    );
    return this;
  }
}

class _$StorageModule extends _i391.StorageModule {}

class _$DioModule extends _i977.DioModule {}
