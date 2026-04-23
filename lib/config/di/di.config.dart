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
import '../../features/forgot_password/api/api/forgot_password_api_client.dart'
    as _i609;
import '../../features/forgot_password/api/data_source/forgot_password_remote_data_source_impl.dart'
    as _i902;
import '../../features/forgot_password/data/data_source/forgot_password_remote_data_source_contract.dart'
    as _i395;
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
import '../../features/profile/api/data_sources/profile_remote_data_source_impl.dart'
    as _i684;
import '../../features/profile/api/profile_api_client/profile_api_client.dart'
    as _i1000;
import '../../features/profile/data/data_sources/profile_remote_data_source_contract.dart'
    as _i427;
import '../../features/profile/data/repo/profile_repo_impl.dart' as _i256;
import '../../features/profile/domain/repo/profile_repo_contract.dart' as _i541;
import '../../features/profile/domain/use_cases/change_password_use_case.dart'
    as _i266;
import '../../features/profile/domain/use_cases/edit_profile_use_case.dart'
    as _i199;
import '../../features/profile/domain/use_cases/get_profile_use_case.dart'
    as _i110;
import '../../features/profile/presentation/view_model/cubit/profile_view_model.dart'
    as _i458;
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
    gh.lazySingleton<_i297.AuthInterceptor>(
      () => _i297.AuthInterceptor(gh<_i558.FlutterSecureStorage>()),
    );
    gh.lazySingleton<_i361.Dio>(
      () => dioModule.dio(gh<_i297.AuthInterceptor>()),
    );
    gh.lazySingleton<_i315.LoginApiClient>(
      () => _i315.LoginApiClient(gh<_i361.Dio>()),
    );
    gh.factory<_i734.ExplorApiClient>(
      () => _i734.ExplorApiClient(gh<_i361.Dio>()),
    );
    gh.factory<_i609.ForgotPasswordApiClient>(
      () => _i609.ForgotPasswordApiClient(gh<_i361.Dio>()),
    );
    gh.factory<_i1000.ProfileApiClient>(
      () => _i1000.ProfileApiClient(gh<_i361.Dio>()),
    );
    gh.factory<_i410.RegisterApiClient>(
      () => _i410.RegisterApiClient(gh<_i361.Dio>()),
    );
    gh.factory<_i395.ForgotPasswordRemoteDataSourceContract>(
      () => _i902.ForgotPasswordRemoteDataSourceImpl(
        gh<_i609.ForgotPasswordApiClient>(),
      ),
    );
    gh.factory<_i684.RegisterRemoteDataSourceContract>(
      () => _i845.RegisterRemoteDataSourceImpl(gh<_i410.RegisterApiClient>()),
    );
    gh.factory<_i511.ForgetPasswordRepoContract>(
      () => _i320.ForgetPasswordRepoImpl(
        gh<_i395.ForgotPasswordRemoteDataSourceContract>(),
      ),
    );
    gh.factory<_i320.ExplorRemoteDataSourceContract>(
      () => _i394.ExplorRemoteDataSourceImpl(gh<_i734.ExplorApiClient>()),
    );
    gh.factory<_i159.LoginRemoteDataSourceContract>(
      () => _i211.LoginRemoteDataSourceImp(gh<_i315.LoginApiClient>()),
    );
    gh.factory<_i427.ProfileRemoteDataSourceContract>(
      () => _i684.ProfileRemoteDataSourceImpl(gh<_i1000.ProfileApiClient>()),
    );
    gh.factory<_i210.RegisterRepositoryContract>(
      () => _i921.RegisterRepositoryImpl(
        gh<_i684.RegisterRemoteDataSourceContract>(),
      ),
    );
    gh.factory<_i597.ForgotPasswordUseCase>(
      () => _i597.ForgotPasswordUseCase(gh<_i511.ForgetPasswordRepoContract>()),
    );
    gh.factory<_i578.ResetPasswordUseCase>(
      () => _i578.ResetPasswordUseCase(gh<_i511.ForgetPasswordRepoContract>()),
    );
    gh.factory<_i717.VerifyResetCodeUseCase>(
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
    gh.factory<_i692.ExplorRepoContract>(
      () => _i1068.ExplorRepoImpl(gh<_i320.ExplorRemoteDataSourceContract>()),
    );
    gh.factory<_i180.LoginRepoContract>(
      () => _i185.LoginRepoImp(
        gh<_i159.LoginRemoteDataSourceContract>(),
        gh<_i558.FlutterSecureStorage>(),
      ),
    );
    gh.factory<_i593.GetSubjectsUseCase>(
      () => _i593.GetSubjectsUseCase(gh<_i692.ExplorRepoContract>()),
    );
    gh.factory<_i679.RegisterUseCase>(
      () => _i679.RegisterUseCase(gh<_i210.RegisterRepositoryContract>()),
    );
    gh.factory<_i541.ProfileRepoContract>(
      () => _i256.ProfileRepoImpl(gh<_i427.ProfileRemoteDataSourceContract>()),
    );
    gh.lazySingleton<_i844.RememberMeUseCase>(
      () => _i844.RememberMeUseCase(
        loginRepoContract: gh<_i180.LoginRepoContract>(),
      ),
    );
    gh.lazySingleton<_i191.LoginUseCase>(
      () => _i191.LoginUseCase(gh<_i180.LoginRepoContract>()),
    );
    gh.factory<_i241.ExplorViewModel>(
      () => _i241.ExplorViewModel(gh<_i593.GetSubjectsUseCase>()),
    );
    gh.lazySingleton<_i266.ChangePasswordUseCase>(
      () => _i266.ChangePasswordUseCase(gh<_i541.ProfileRepoContract>()),
    );
    gh.lazySingleton<_i199.EditProfileUseCase>(
      () => _i199.EditProfileUseCase(gh<_i541.ProfileRepoContract>()),
    );
    gh.lazySingleton<_i110.GetProfileUseCase>(
      () => _i110.GetProfileUseCase(gh<_i541.ProfileRepoContract>()),
    );
    gh.factory<_i166.RegisterViewModel>(
      () => _i166.RegisterViewModel(gh<_i679.RegisterUseCase>()),
    );
    gh.factory<_i705.LoginViewModel>(
      () => _i705.LoginViewModel(
        gh<_i191.LoginUseCase>(),
        rememberMeUseCase: gh<_i844.RememberMeUseCase>(),
      ),
    );
    gh.factory<_i458.ProfileViewModel>(
      () => _i458.ProfileViewModel(
        gh<_i110.GetProfileUseCase>(),
        gh<_i199.EditProfileUseCase>(),
        gh<_i266.ChangePasswordUseCase>(),
      ),
    );
    return this;
  }
}

class _$StorageModule extends _i391.StorageModule {}

class _$DioModule extends _i977.DioModule {}
