import 'dart:developer';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam_app_v/config/base_responce/base_response.dart';
import 'package:online_exam_app_v/core/constants/app_api_param.dart';
import 'package:online_exam_app_v/core/network/api_error_handler.dart';
import 'package:online_exam_app_v/features/login/data/data_sources/login_remote_data_source_contract.dart';
import 'package:online_exam_app_v/features/login/data/models/login_request.dart';
import 'package:online_exam_app_v/features/login/domain/entities/user_entity.dart';
import 'package:online_exam_app_v/features/login/domain/repo/login_repo_contract.dart';

@Injectable(as: LoginRepoContract)
class LoginRepoImp implements LoginRepoContract {
  final LoginRemoteDataSourceContract loginRemoteDataSourceContract;
  final FlutterSecureStorage secureStorage;

  LoginRepoImp(this.loginRemoteDataSourceContract, this.secureStorage);

  @override
  Future<BaseResponse<UserEntity>> login(LoginRequest loginRequest) async {
    try {
      final response = await loginRemoteDataSourceContract.login(loginRequest);
      log(response.toString());
      return SuccessBaseResponse<UserEntity>(data: response.toEntity());
    } catch (e) {
      return ErrorBaseResponse(
        errorMessage: ApiErrorHandler.getErrorMessage(e),
      );
    }
  }

  @override
  void rememberMe(bool rememberMe) {
    secureStorage.write(
      key: AppApiParam.rememberMe,
      value: rememberMe.toString(),
    );
  }

  @override
  Future<bool?> isRememberedMe() async {
    final result = await secureStorage.read(key: AppApiParam.rememberMe);
    if (result != null) return bool.parse(result);
    return null;
  }
}
