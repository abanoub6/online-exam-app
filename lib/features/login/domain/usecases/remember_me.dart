import 'package:injectable/injectable.dart';
import 'package:online_exam_app_v/features/login/domain/repositories/login_repo_contract.dart';
@lazySingleton
class RememberMeUseCase {
  final LoginRepoContract loginRepoContract;

  RememberMeUseCase({required this.loginRepoContract});
  void rememberMe(bool rememberMe) {
    loginRepoContract.rememberMe(rememberMe);
  }

  Future<bool?> isRememberedMe() async{
   return await loginRepoContract.isRememberedMe();
  }
}
