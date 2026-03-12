import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam_app_v/features/forgot_password/domain/use_cases/forgot_password_use_case.dart';
import 'package:online_exam_app_v/features/forgot_password/domain/use_cases/verify_reset_code_use_case.dart';
import 'package:online_exam_app_v/features/forgot_password/presentation/view_model/states/verify_reset_code_state.dart';

@injectable
class VerifyResetCodeCubit extends Cubit<VerifyResetCodeState> {
  final VerifyResetCodeUseCase _verifyResetCodeUseCase;
  final ForgotPasswordUseCase _forgotPasswordUseCase;

  VerifyResetCodeCubit(
    this._verifyResetCodeUseCase,
    this._forgotPasswordUseCase,
  ) : super(VerifyResetCodeInitial());

  String _code = '';

  void setCode(String code) => _code = code;

  Future<void> verifyCode() async {
    if (_code.length != 6) {
      emit(VerifyResetCodeFailure('Please enter the complete 6-digit code'));
      return;
    }

    emit(VerifyResetCodeLoading());

    final result = await _verifyResetCodeUseCase(resetCode: _code);

    result.fold(
      (failure) => emit(VerifyResetCodeFailure(failure.message)),
      (response) => emit(VerifyResetCodeSuccess(response.status)),
    );
  }

  Future<void> resendCode(String email) async {
    final result = await _forgotPasswordUseCase(email: email);

    result.fold(
      (failure) => emit(VerifyResetCodeFailure(failure.message)),
      (_) => emit(VerifyResetCodeCodeResent()),
    );
  }
}
