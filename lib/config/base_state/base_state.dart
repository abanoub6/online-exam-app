import 'dart:developer';

import 'package:online_exam_app_v/features/login/domain/entities/user_entity.dart';

class BaseState<T> {
  bool isLoading = false;
  String? errorMessage;
  T? data;

  BaseState({this.isLoading = false, this.errorMessage, this.data});

  BaseState<T> copyWith({
    bool? isLoadingParam,
    String? errorMessageParam,
    T? dataParam,
    required bool isLoading,
    String? errorMessage,
    T? data,
  }) {
    return BaseState<T>(
      isLoading: isLoadingParam ?? isLoading,
      data: data ?? this.data,
      errorMessage: errorMessage ?? this.errorMessage
    );
  }

  @override
  String toString() {
    log(
      "isLoading: $isLoading\ndata ${data.toString()}\nerrorMessage ${errorMessage.toString()}",
    );
    return super.toString();
  }
}
