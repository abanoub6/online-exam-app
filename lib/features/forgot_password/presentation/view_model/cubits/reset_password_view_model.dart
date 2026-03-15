import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam_app_v/features/forgot_password/domain/use_cases/reset_password_use_case.dart';
import 'package:online_exam_app_v/features/forgot_password/presentation/view_model/states/reset_password_state.dart';

@injectable
class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  final ResetPasswordUseCase _resetPasswordUseCase;

  ResetPasswordCubit(this._resetPasswordUseCase)
    : super(ResetPasswordInitial());

  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  Future<void> resetPassword({required String email}) async {
    if (!formKey.currentState!.validate()) return;

    emit(ResetPasswordLoading());

    final result = await _resetPasswordUseCase(
      email: email,
      newPassword: passwordController.text,
    );

    result.fold(
      (failure) => emit(ResetPasswordFailure(failure.message)),
      (response) => emit(ResetPasswordSuccess(response.token)),
    );
  }

  @override
  Future<void> close() {
    passwordController.dispose();
    confirmPasswordController.dispose();
    return super.close();
  }
}
