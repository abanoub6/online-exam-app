<<<<<<< HEAD
=======
import 'dart:developer';

import 'package:online_exam_app_v/features/login/domain/entities/user_entity.dart';

>>>>>>> 22589478c27956ed8f971823d66ac2b102068ab3
class BaseState<T> {
  bool isLoading = false;
  String? errorMessage;
  T? data;

  BaseState({this.isLoading = false, this.errorMessage, this.data});

  BaseState<T> copyWith({
    bool? isLoadingParam,
    String? errorMessageParam,
    T? dataParam,
  }) {
    return BaseState<T>(
      isLoading: isLoadingParam ?? isLoading,
      errorMessage: errorMessageParam ?? errorMessage,
      data: dataParam ?? data,
    );
  }
}
