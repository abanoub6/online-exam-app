import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam_app_v/config/base_responce/base_response.dart';
import 'package:online_exam_app_v/config/base_state/base_state.dart';
import 'package:online_exam_app_v/features/login/data/models/login_request.dart';
import 'package:online_exam_app_v/features/login/domain/entities/user_entity.dart';
import 'package:online_exam_app_v/features/login/domain/use_cases/login_use_case.dart';
import 'package:online_exam_app_v/features/login/domain/use_cases/remember_me.dart';
import 'package:online_exam_app_v/features/login/presentation/view_model/states/login_events.dart';
import 'package:online_exam_app_v/features/login/presentation/view_model/states/login_state.dart';

@injectable
class LoginViewModel extends Cubit<LoginStates> {
  LoginViewModel(
    this.loginUseCase, {
    required RememberMeUseCase rememberMeUseCase,
  }) : _rememberMeUseCase = rememberMeUseCase,
       super(LoginStates(loginState: BaseState<UserEntity>()));
  final LoginUseCase loginUseCase;
  final RememberMeUseCase _rememberMeUseCase;

  void doEvent(LoginEvents event) async {
    switch (event) {
      case LoginUserEvent(login: final login):
        await _login(login);
        break;
      // case ClearUserEvent() : _Error();break ;
    }
  }

  Future<void> _login(LoginRequest loginRequest) async {
    emit(
      state.copyWith(loginStateParam: BaseState<UserEntity>(isLoading: true)),
    );

    final result = await loginUseCase.call(loginRequest);

    switch (result) {
      case SuccessBaseResponse<UserEntity>():
        log(result.data.toString());
        emit(
          state.copyWith(
            loginStateParam: BaseState<UserEntity>(data: result.data),
          ),
        );
        _rememberMeUseCase.rememberMe(loginRequest.rememberMe);

      case ErrorBaseResponse<UserEntity>():
        emit(
          state.copyWith(
            loginStateParam: BaseState<UserEntity>(
              errorMessage: result.errorMessage,
            ),
          ),
        );
    }
  }
}
