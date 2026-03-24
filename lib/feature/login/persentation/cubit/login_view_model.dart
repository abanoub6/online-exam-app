import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam_app_v/config/base_responce/base_responce.dart';
import 'package:online_exam_app_v/feature/login/data/models/login_request.dart';
import 'package:online_exam_app_v/feature/login/data/models/login_response_model.dart';
import 'package:online_exam_app_v/feature/login/data/models/user_model.dart';
import 'package:online_exam_app_v/feature/login/domain/entities/user_entity.dart';
import 'package:online_exam_app_v/feature/login/persentation/cubit/login_state.dart';

import '../../domain/usecases/login_use_case.dart';

@injectable
class LoginViewModel extends Cubit<LoginState> {
  LoginViewModel(this.loginUseCase) : super(LoginInitial());
  final LoginUseCase loginUseCase;

  Future<void> login(LoginRequest loginRequest) async {
    emit(LoginLoading());
    final response = await loginUseCase(loginRequest);
  }
}
