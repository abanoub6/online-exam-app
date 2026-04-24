import 'package:online_exam_app_v/config/base_state/base_state.dart';
import 'package:online_exam_app_v/features/forgot_password/domain/entities/forget_password_entity.dart';

sealed class ForgotPasswordState extends BaseState<ForgotPasswordEntity> {
  ForgotPasswordState({super.isLoading, super.errorMessage, super.data});
}

class ForgotPasswordInitial extends ForgotPasswordState {
  ForgotPasswordInitial() : super();
}

class ForgotPasswordEmailLoading extends ForgotPasswordState {
  ForgotPasswordEmailLoading() : super(isLoading: true);
}

class ForgotPasswordEmailSuccess extends ForgotPasswordState {
  ForgotPasswordEmailSuccess(ForgotPasswordEntity entity) : super(data: entity);
}

class ForgotPasswordEmailFailure extends ForgotPasswordState {
  ForgotPasswordEmailFailure(String error) : super(errorMessage: error);
}

class ForgotPasswordVerifyLoading extends ForgotPasswordState {
  ForgotPasswordVerifyLoading() : super(isLoading: true);
}

class ForgotPasswordVerifySuccess extends ForgotPasswordState {
  ForgotPasswordVerifySuccess(ForgotPasswordEntity entity)
    : super(data: entity);
}

class ForgotPasswordVerifyFailure extends ForgotPasswordState {
  ForgotPasswordVerifyFailure(String error) : super(errorMessage: error);
}

class ForgotPasswordCodeResent extends ForgotPasswordState {
  ForgotPasswordCodeResent() : super();
}

class ForgotPasswordResetLoading extends ForgotPasswordState {
  ForgotPasswordResetLoading() : super(isLoading: true);
}

class ForgotPasswordResetSuccess extends ForgotPasswordState {
  ForgotPasswordResetSuccess(ForgotPasswordEntity entity) : super(data: entity);
}

class ForgotPasswordResetFailure extends ForgotPasswordState {
  ForgotPasswordResetFailure(String error) : super(errorMessage: error);
}
