import 'package:injectable/injectable.dart';
<<<<<<<< HEAD:lib/features/login/domain/use_cases/remember_me.dart
import 'package:online_exam_app_v/features/login/domain/repo/login_repo_contract.dart';

========
import 'package:online_exam_app_v/features/login/domain/repositories/login_repo_contract.dart';
>>>>>>>> 22589478c27956ed8f971823d66ac2b102068ab3:lib/features/login/domain/usecases/remember_me.dart
@lazySingleton
class RememberMeUseCase {
  final LoginRepoContract loginRepoContract;

  RememberMeUseCase({required this.loginRepoContract});
  void rememberMe(bool rememberMe) {
    loginRepoContract.rememberMe(rememberMe);
  }

  Future<bool?> isRememberedMe() async {
    return await loginRepoContract.isRememberedMe();
  }
}
