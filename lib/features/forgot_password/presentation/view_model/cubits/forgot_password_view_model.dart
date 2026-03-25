import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam_app_v/config/base_responce/base_response.dart';
import 'package:online_exam_app_v/features/forgot_password/domain/entities/forget_password_entity.dart';
import 'package:online_exam_app_v/features/forgot_password/domain/use_cases/forgot_password_use_case.dart';
import 'package:online_exam_app_v/features/forgot_password/domain/use_cases/reset_password_use_case.dart';
import 'package:online_exam_app_v/features/forgot_password/domain/use_cases/verify_reset_code_use_case.dart';
import 'package:online_exam_app_v/features/forgot_password/presentation/view_model/states/forgot_password_events.dart';
import 'package:online_exam_app_v/features/forgot_password/presentation/view_model/states/forgot_password_state.dart';

@injectable
class ForgotPasswordViewModel extends Cubit<ForgotPasswordState> {
  final ForgotPasswordUseCase _forgotPasswordUseCase;
  final VerifyResetCodeUseCase _verifyResetCodeUseCase;
  final ResetPasswordUseCase _resetPasswordUseCase;

  ForgotPasswordViewModel(
    this._forgotPasswordUseCase,
    this._verifyResetCodeUseCase,
    this._resetPasswordUseCase,
  ) : super(const ForgotPasswordInitial());

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final emailFormKey = GlobalKey<FormState>();
  final resetFormKey = GlobalKey<FormState>();

  String _verifyCode = '';
  String _email = '';

  void setCode(String code) => _verifyCode = code;

  Future<void> doEvent(ForgotPasswordEvents event) async {
    switch (event) {
      case SendEmailEvent():
        await _sendEmail();
      case VerifyCodeEvent():
        await _verifyCode_();
      case ResendCodeEvent():
        await _resendCode();
      case ResetPasswordEvent():
        await _resetPassword();
    }
  }

  Future<void> _sendEmail() async {
    if (!emailFormKey.currentState!.validate()) return;

    _email = emailController.text.trim();
    emit(const ForgotPasswordEmailLoading());

    final result = await _forgotPasswordUseCase(email: _email);

    switch (result) {
      case SuccessBaseResponse<ForgotPasswordEntity>():
        emit(
          ForgotPasswordEmailSuccess(result.data.message ?? result.data.info),
        );
      case ErrorBaseResponse<ForgotPasswordEntity>():
        emit(ForgotPasswordEmailFailure(result.errorMessage));
    }
  }

  Future<void> _verifyCode_() async {
    if (_verifyCode.length != 6) {
      emit(
        const ForgotPasswordVerifyFailure(
          'Please enter the complete 6-digit code',
        ),
      );
      return;
    }

    emit(const ForgotPasswordVerifyLoading());

    final result = await _verifyResetCodeUseCase(resetCode: _verifyCode);

    switch (result) {
      case SuccessBaseResponse<ForgotPasswordEntity>():
        emit(ForgotPasswordVerifySuccess(result.data.status));
      case ErrorBaseResponse<ForgotPasswordEntity>():
        emit(ForgotPasswordVerifyFailure(result.errorMessage));
    }
  }

  Future<void> _resendCode() async {
    final result = await _forgotPasswordUseCase(email: _email);

    switch (result) {
      case SuccessBaseResponse<ForgotPasswordEntity>():
        emit(const ForgotPasswordCodeResent());
      case ErrorBaseResponse<ForgotPasswordEntity>():
        emit(ForgotPasswordVerifyFailure(result.errorMessage));
    }
  }

  Future<void> _resetPassword() async {
    if (!resetFormKey.currentState!.validate()) return;

    emit(const ForgotPasswordResetLoading());

    final result = await _resetPasswordUseCase(
      email: _email,
      newPassword: passwordController.text,
    );

    switch (result) {
      case SuccessBaseResponse<ForgotPasswordEntity>():
        emit(ForgotPasswordResetSuccess(result.data.token));
      case ErrorBaseResponse<ForgotPasswordEntity>():
        emit(ForgotPasswordResetFailure(result.errorMessage));
    }
  }

  @override
  Future<void> close() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    return super.close();
  }
}
