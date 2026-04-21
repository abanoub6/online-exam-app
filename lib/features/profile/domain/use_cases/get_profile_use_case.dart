import 'package:injectable/injectable.dart';
import 'package:online_exam_app_v/config/base_responce/base_response.dart';
import 'package:online_exam_app_v/features/profile/domain/entities/profile_entity.dart';
import 'package:online_exam_app_v/features/profile/domain/repo/profile_repo_contract.dart';

@lazySingleton
class GetProfileUseCase {
  final ProfileRepoContract _repo;
  const GetProfileUseCase(this._repo);

  Future<BaseResponse<ProfileEntity>> call() => _repo.getProfile();
}
