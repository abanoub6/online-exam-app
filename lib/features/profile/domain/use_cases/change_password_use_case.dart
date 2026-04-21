import 'package:injectable/injectable.dart';
import 'package:online_exam_app_v/config/base_responce/base_response.dart';
import 'package:online_exam_app_v/features/profile/data/models/change_password_request.dart';
import 'package:online_exam_app_v/features/profile/domain/repo/profile_repo_contract.dart';

@lazySingleton
class ChangePasswordUseCase {
  final ProfileRepoContract _repo;
  const ChangePasswordUseCase(this._repo);

  Future<BaseResponse<String>> call(ChangePasswordRequest request) =>
      _repo.changePassword(request);
}
