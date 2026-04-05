import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam_app_v/config/base_responce/base_response.dart';
<<<<<<<< HEAD:lib/features/login/presentation/cubit/login_view_model/login_view_model.dart
import 'package:online_exam_app_v/config/base_state/base_state.dart';
import 'package:online_exam_app_v/features/login/data/models/login_request.dart';
import 'package:online_exam_app_v/features/login/domain/entities/user_entity.dart';
import 'package:online_exam_app_v/features/login/domain/use_cases/remember_me.dart';
import 'package:online_exam_app_v/features/login/presentation/cubit/states/login_events.dart';
import 'package:online_exam_app_v/features/login/presentation/cubit/states/login_state.dart';
========

import 'package:online_exam_app_v/config/base_state/base_state.dart';
import 'package:online_exam_app_v/features/login/data/models/login_request.dart';
import 'package:online_exam_app_v/features/login/domain/entities/user_entity.dart';
import 'package:online_exam_app_v/features/login/domain/usecases/remember_me.dart';
import 'package:online_exam_app_v/features/login/persentation/states/login_events.dart';
import 'package:online_exam_app_v/features/login/persentation/states/login_state.dart';
>>>>>>>> 22589478c27956ed8f971823d66ac2b102068ab3:lib/features/login/persentation/cubit/login_view_model.dart

import '../../../domain/use_cases/login_use_case.dart';

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
      state.copyWith(
        loginStateParam: state.loginState.copyWith(
          isLoading: true,
          errorMessage: null,
          data: null,
        ),
      ),
    );
    final responce = await loginUseCase.call(loginRequest);
    switch (responce) {
      case SuccessBaseResponse<UserEntity>(data: final data):
        {
          log(data.toString());
          final base = state.loginState.copyWith(isLoading: false, data: data);
          emit(state.copyWith(loginStateParam: base));
          _rememberMeUseCase.rememberMe(loginRequest.rememberMe);
        }
      case ErrorBaseResponse<UserEntity>(errorMessage: final errorMessage):
        {
          emit(
            state.copyWith(
              loginStateParam: state.loginState.copyWith(
                isLoading: false,
                errorMessage: errorMessage,
              ),
            ),
          );
        }
    }
  }
}
