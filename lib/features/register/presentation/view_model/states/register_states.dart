import 'package:online_exam_app_v/config/base_state/base_state.dart';
import 'package:online_exam_app_v/features/register/domain/entities/user_entity.dart';

class RegisterStates {
  BaseState<UserEntity> registerState = BaseState<UserEntity>(isLoading: false);

  RegisterStates({BaseState<UserEntity>? registerState}) {
    this.registerState =
        registerState ?? BaseState<UserEntity>(isLoading: false);
  }

  RegisterStates copyWith({BaseState<UserEntity>? registerStateParam}) {
    return RegisterStates(registerState: registerStateParam ?? registerState);
  }
}
