import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam_app_v/config/base_responce/base_response.dart';
import 'package:online_exam_app_v/features/register/data/models/register_request.dart';
import 'package:online_exam_app_v/features/register/domain/entities/user_entity.dart';
import 'package:online_exam_app_v/features/register/domain/use_cases/register_usecase.dart';
import 'package:online_exam_app_v/features/register/presentation/view_model/states/register_events.dart';
import 'package:online_exam_app_v/features/register/presentation/view_model/states/register_states.dart';

@singleton
class RegisterViewModel extends Cubit<RegisterStates> {
  final RegisterUseCase registerUseCase;

  RegisterViewModel(this.registerUseCase) : super(RegisterStates());

  /// form key
  final formKey = GlobalKey<FormState>();

  /// controllers
  final usernameController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final phoneController = TextEditingController();

  @override
  Future<void> close() {
    usernameController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    phoneController.dispose();
    return super.close();
  }

  bool isFormValid = false;

  void validateForm() {
    final valid = formKey.currentState?.validate() ?? false;

    if (valid != isFormValid) {
      isFormValid = valid;
      emit(state.copyWith());
    }
  }

  void doEvent(RegisterEvents event) {
    switch (event) {
      case RegisterUserEvent():
        _register();
        break;

      case ClearRegisterErrorEvent():
        _clearError();
        break;
    }
  }

  void _clearError() {
    emit(
      state.copyWith(
        registerStateParam: state.registerState.copyWith(
          errorMessage: null,
        ),
      ),
    );
  }

  Future<void> _register() async {
    if (!(formKey.currentState?.validate() ?? false)) return;

    final request = RegisterRequest(
      username: usernameController.text,
      firstName: firstNameController.text,
      lastName: lastNameController.text,
      email: emailController.text,
      password: passwordController.text,
      rePassword: confirmPasswordController.text,
      phone: phoneController.text,
    );

    /// start loading
    emit(
      state.copyWith(
        registerStateParam: state.registerState.copyWith(
          isLoading: true,
          errorMessage: null,
        ),
      ),
    );

    final response = await registerUseCase(registerRequest: request);

    switch (response) {
      case SuccessBaseResponse<UserEntity>():
        emit(
          state.copyWith(
            registerStateParam: state.registerState.copyWith(
              isLoading: false,
              data: response.data,
            ),
          ),
        );
        break;

      case ErrorBaseResponse<UserEntity>():
        emit(
          state.copyWith(
            registerStateParam: state.registerState.copyWith(
              isLoading: false,
              errorMessage: response.errorMessage,
            ),
          ),
        );
        break;
    }
  }
}
