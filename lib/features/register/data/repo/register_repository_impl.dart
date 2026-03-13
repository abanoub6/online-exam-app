import 'package:injectable/injectable.dart';
import 'package:online_exam_app_v/config/base_responce/base_response.dart';
import 'package:online_exam_app_v/features/register/data/data_sources/register_remote_data_source_contract.dart';
import 'package:online_exam_app_v/features/register/data/models/register_request.dart';
import 'package:online_exam_app_v/features/register/data/models/user_dto.dart';
import 'package:online_exam_app_v/features/register/domain/entities/user_entity.dart';
import 'package:online_exam_app_v/features/register/domain/repo/register_repository_contract.dart';

@Injectable(as: RegisterRepositoryContract)
class AuthRepositoryImpl implements RegisterRepositoryContract {
  final RegisterRemoteDataSourceContract remoteDataSource;

  AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<BaseResponse<UserEntity>> register({
    required RegisterRequest registerRequest,
  }) async {
    final response = await remoteDataSource.register(registerRequest);

    switch (response) {
      case SuccessBaseResponse<UserDto>():
        return SuccessBaseResponse<UserEntity>(data: response.data.toEntity());
      case ErrorBaseResponse<UserDto>():
        return ErrorBaseResponse<UserEntity>(
          errorMessage: response.errorMessage,
        );
    }
  }
}
