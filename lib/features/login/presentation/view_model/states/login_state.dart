import 'package:equatable/equatable.dart';
import 'package:online_exam_app_v/config/base_state/base_state.dart';
import 'package:online_exam_app_v/features/login/domain/entities/user_entity.dart';

class LoginStates extends Equatable {
  final BaseState<UserEntity> loginState;

  LoginStates({BaseState<UserEntity>? loginState})
    : loginState = loginState ?? BaseState<UserEntity>(isLoading: false);

  LoginStates copyWith({BaseState<UserEntity>? loginStateParam}) =>
      LoginStates(loginState: loginStateParam ?? loginState);

  @override
  List<Object?> get props => [loginState];
}
