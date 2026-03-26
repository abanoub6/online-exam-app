import 'dart:developer';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam_app_v/config/base_responce/base_responce.dart';
import 'package:online_exam_app_v/core/constants/app_api_param.dart';
import 'package:online_exam_app_v/features/login/data/datasources/login_remote_data_source_contract.dart';
import 'package:online_exam_app_v/features/login/data/models/login_request.dart';
import 'package:online_exam_app_v/features/login/data/models/user_model.dart';
import 'package:online_exam_app_v/features/login/domain/entities/user_entity.dart';
import 'package:online_exam_app_v/features/login/domain/repositories/login_repo_contract.dart';

@Injectable(as: LoginRepoContract)
class LoginRepoImp implements LoginRepoContract {
  LoginRepoImp(this.loginRemoteDataSourceContract);
  LoginRemoteDataSourceContract loginRemoteDataSourceContract;
  @override
  Future<BaseResponse<UserEntity>> login(LoginRequest loginRequest) async {
    BaseResponse<UserModel> response = await loginRemoteDataSourceContract
        .login(loginRequest);

    log(response.runtimeType.toString());
    switch (response) {
      case SuccessBaseResponse<UserModel>():
        return SuccessBaseResponse<UserEntity>(data: response.data.toEntity());
      case ErrorBaseResponse<UserModel>():
        return ErrorBaseResponse<UserEntity>(
          errorMessage: response.errorMessage,
        );
    }
  }

  @override
  void rememberMe(bool rememberMe) {
    FlutterSecureStorage().write(
      key: AppApiParam.rememberMe,
      value: rememberMe.toString(),
    );
  }

  @override
  Future<bool?> isRememberedMe() async {
    final result = await FlutterSecureStorage().read(
      key: AppApiParam.rememberMe,
    );
    if (result != null) return bool.parse(result);
    return null;
  }
}
