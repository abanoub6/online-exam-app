import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam_app_v/features/forgot_password/domain/use_cases/forgot_password_use_case.dart';
import 'package:online_exam_app_v/features/forgot_password/presentation/view_model/states/forgot_password_state.dart';

@injectable
class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  final ForgotPasswordUseCase _forgotPasswordUseCase;

  ForgotPasswordCubit(this._forgotPasswordUseCase)
    : super(ForgotPasswordInitial());

  final emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  Future<void> forgotPassword() async {
    if (!formKey.currentState!.validate()) return;

    emit(ForgotPasswordLoading());

    final result = await _forgotPasswordUseCase(
      email: emailController.text.trim(),
    );

    result.fold(
      (failure) => emit(ForgotPasswordFailure(failure.message)),
      (response) =>
          emit(ForgotPasswordSuccess(response.message ?? response.info)),
    );
  }

  @override
  Future<void> close() {
    emailController.dispose();
    return super.close();
  }
}
