import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam_app_v/config/base_responce/base_responce.dart';
import 'package:online_exam_app_v/features/register/data/models/register_request.dart';
import 'package:online_exam_app_v/features/register/domain/entities/user_entity.dart';
import 'package:online_exam_app_v/features/register/domain/use_cases/register_usecase.dart';
import 'package:online_exam_app_v/features/register/presentation/view_model/states/register_states.dart';

@singleton
class RegisterCubit extends Cubit<RegisterStates> {
  final RegisterUseCase useCase;
  void clearError() {
    emit(
      state.copyWith(
        registerStateParam: state.registerState.copyWith(
          errorMessageParam: null,
        ),
      ),
    );
  }

  RegisterCubit(this.useCase) : super(RegisterStates());

  Future<void> register({required RegisterRequest registerRequest}) async {
    /// start loading
    emit(
      state.copyWith(
        registerStateParam: state.registerState.copyWith(
          isLoadingParam: true,
          errorMessageParam: null,
        ),
      ),
    );

    final response = await useCase(registerRequest: registerRequest);

    switch (response) {
      /// SUCCESS
      case SuccessBaseResponse<UserEntity>():
        emit(
          state.copyWith(
            registerStateParam: state.registerState.copyWith(
              isLoadingParam: false,
              dataParam: response.data,
              errorMessageParam: null,
            ),
          ),
        );
        break;

      /// ERROR
      case ErrorBaseResponse<UserEntity>():
        emit(
          state.copyWith(
            registerStateParam: state.registerState.copyWith(
              isLoadingParam: false,
              errorMessageParam: response.errorMessage,
            ),
          ),
        );
        break;
    }
  }
}
