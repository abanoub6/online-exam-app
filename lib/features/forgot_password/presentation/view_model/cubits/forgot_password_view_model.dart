import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam_app_v/config/base_responce/base_response.dart';
import 'package:online_exam_app_v/core/constants/app_strings.dart';
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
  ) : super(ForgotPasswordInitial());

  Future<void> doEvent(ForgotPasswordEvents event) async {
    switch (event) {
      case SendEmailEvent():
        await _sendEmail(event.email);
      case VerifyCodeEvent():
        await _verifyCode(event.code);
      case ResendCodeEvent():
        await _resendCode(event.email);
      case ResetPasswordEvent():
        await _resetPassword(event.email, event.password);
    }
  }

  Future<void> _sendEmail(String email) async {
    emit(ForgotPasswordEmailLoading());
    final result = await _forgotPasswordUseCase(email: email);
    switch (result) {
      case SuccessBaseResponse<ForgotPasswordEntity>():
        emit(ForgotPasswordEmailSuccess(result.data));
      case ErrorBaseResponse<ForgotPasswordEntity>():
        emit(ForgotPasswordEmailFailure(result.errorMessage));
    }
  }

  Future<void> _verifyCode(String code) async {
    if (code.length != 6) {
      emit(ForgotPasswordVerifyFailure(AppStrings.pleaseEnterTheCompleteCode));
      return;
    }
    emit(ForgotPasswordVerifyLoading());
    final result = await _verifyResetCodeUseCase(resetCode: code);
    switch (result) {
      case SuccessBaseResponse<ForgotPasswordEntity>():
        emit(ForgotPasswordVerifySuccess(result.data));
      case ErrorBaseResponse<ForgotPasswordEntity>():
        emit(ForgotPasswordVerifyFailure(result.errorMessage));
    }
  }

  Future<void> _resendCode(String email) async {
    final result = await _forgotPasswordUseCase(email: email);
    switch (result) {
      case SuccessBaseResponse<ForgotPasswordEntity>():
        emit(ForgotPasswordCodeResent());
      case ErrorBaseResponse<ForgotPasswordEntity>():
        emit(ForgotPasswordVerifyFailure(result.errorMessage));
    }
  }

  Future<void> _resetPassword(String email, String password) async {
    emit(ForgotPasswordResetLoading());
    final result = await _resetPasswordUseCase(
      email: email,
      newPassword: password,
    );
    switch (result) {
      case SuccessBaseResponse<ForgotPasswordEntity>():
        emit(ForgotPasswordResetSuccess(result.data));
      case ErrorBaseResponse<ForgotPasswordEntity>():
        emit(ForgotPasswordResetFailure(result.errorMessage));
    }
  }
}
