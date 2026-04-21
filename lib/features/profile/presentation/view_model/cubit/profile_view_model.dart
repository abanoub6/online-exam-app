import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam_app_v/config/base_responce/base_response.dart';
import 'package:online_exam_app_v/features/profile/data/models/change_password_request.dart';
import 'package:online_exam_app_v/features/profile/data/models/edit_profile_request.dart';
import 'package:online_exam_app_v/features/profile/domain/entities/profile_entity.dart';
import 'package:online_exam_app_v/features/profile/domain/use_cases/change_password_use_case.dart';
import 'package:online_exam_app_v/features/profile/domain/use_cases/edit_profile_use_case.dart';
import 'package:online_exam_app_v/features/profile/domain/use_cases/get_profile_use_case.dart';
import 'package:online_exam_app_v/features/profile/presentation/view_model/states/profile_events.dart';
import 'package:online_exam_app_v/features/profile/presentation/view_model/states/profile_state.dart';

@injectable
class ProfileViewModel extends Cubit<ProfileState> {
  final GetProfileUseCase _getProfileUseCase;
  final EditProfileUseCase _editProfileUseCase;
  final ChangePasswordUseCase _changePasswordUseCase;

  ProfileViewModel(
    this._getProfileUseCase,
    this._editProfileUseCase,
    this._changePasswordUseCase,
  ) : super(ProfileInitial());

  Future<void> doEvent(ProfileEvents event) async {
    switch (event) {
      case GetProfileEvent():
        await _getProfile();
      case EditProfileEvent():
        await _editProfile(event.request);
      case ChangePasswordEvent():
        await _changePassword(event.request);
    }
  }

  Future<void> _getProfile() async {
    emit(GetProfileLoading());
    final result = await _getProfileUseCase();
    switch (result) {
      case SuccessBaseResponse<ProfileEntity>():
        emit(GetProfileSuccess(result.data));
      case ErrorBaseResponse<ProfileEntity>():
        emit(GetProfileFailure(result.errorMessage));
    }
  }

  Future<void> _editProfile(EditProfileRequest request) async {
    emit(EditProfileLoading());
    final result = await _editProfileUseCase(request);
    switch (result) {
      case SuccessBaseResponse<ProfileEntity>():
        emit(EditProfileSuccess(result.data));
      case ErrorBaseResponse<ProfileEntity>():
        emit(EditProfileFailure(result.errorMessage));
    }
  }

  Future<void> _changePassword(ChangePasswordRequest request) async {
    emit(ChangePasswordLoading());
    final result = await _changePasswordUseCase(request);
    switch (result) {
      case SuccessBaseResponse<String>():
        emit(ChangePasswordSuccess());
      case ErrorBaseResponse<String>():
        emit(ChangePasswordFailure(result.errorMessage));
    }
  }
}
