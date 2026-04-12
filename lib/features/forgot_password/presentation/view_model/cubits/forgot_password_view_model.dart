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

  String _email = '';
  String _verifyCode = '';

  void setCode(String code) => _verifyCode = code;

  Future<void> doEvent(ForgotPasswordEvents event) async {
    switch (event) {
      case SendEmailEvent():
        await _sendEmail(event.email);
      case VerifyCodeEvent():
        await _verifyCode_();
      case ResendCodeEvent():
        await _resendCode();
      case ResetPasswordEvent():
        await _resetPassword(event.password);
    }
  }

  Future<void> _sendEmail(String email) async {
    _email = email;
    emit(ForgotPasswordEmailLoading());

    final result = await _forgotPasswordUseCase(email: _email);

    switch (result) {
      case SuccessBaseResponse<ForgotPasswordEntity>():
        emit(ForgotPasswordEmailSuccess(result.data));
      case ErrorBaseResponse<ForgotPasswordEntity>():
        emit(ForgotPasswordEmailFailure(result.errorMessage ?? ''));
    }
  }

  Future<void> _verifyCode_() async {
    if (_verifyCode.length != 6) {
      emit(ForgotPasswordVerifyFailure(AppStrings.pleaseEnterTheCompleteCode));
      return;
    }

    emit(ForgotPasswordVerifyLoading());

    final result = await _verifyResetCodeUseCase(resetCode: _verifyCode);

    switch (result) {
      case SuccessBaseResponse<ForgotPasswordEntity>():
        emit(ForgotPasswordVerifySuccess(result.data));
      case ErrorBaseResponse<ForgotPasswordEntity>():
        emit(ForgotPasswordVerifyFailure(result.errorMessage ?? ''));
    }
  }

  Future<void> _resendCode() async {
    final result = await _forgotPasswordUseCase(email: _email);

    switch (result) {
      case SuccessBaseResponse<ForgotPasswordEntity>():
        emit(ForgotPasswordCodeResent());
      case ErrorBaseResponse<ForgotPasswordEntity>():
        emit(ForgotPasswordVerifyFailure(result.errorMessage ?? ''));
    }
  }

  Future<void> _resetPassword(String password) async {
    emit(ForgotPasswordResetLoading());

    final result = await _resetPasswordUseCase(
      email: _email,
      newPassword: password,
    );

    switch (result) {
      case SuccessBaseResponse<ForgotPasswordEntity>():
        emit(ForgotPasswordResetSuccess(result.data));
      case ErrorBaseResponse<ForgotPasswordEntity>():
        emit(ForgotPasswordResetFailure(result.errorMessage ?? ''));
    }
  }
}
