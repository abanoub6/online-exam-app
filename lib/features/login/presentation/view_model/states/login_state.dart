import 'package:online_exam_app_v/config/base_state/base_state.dart';
import 'package:online_exam_app_v/features/login/domain/entities/user_entity.dart';

class LoginStates {
  BaseState<UserEntity> loginState = BaseState<UserEntity>(isLoading: false);

  LoginStates({BaseState<UserEntity>? loginState}) {
    this.loginState = loginState ?? BaseState<UserEntity>(isLoading: false);
  }

  LoginStates copyWith({BaseState<UserEntity>? loginStateParam}) {
    return LoginStates(loginState: loginStateParam ?? loginState);
  }
}
