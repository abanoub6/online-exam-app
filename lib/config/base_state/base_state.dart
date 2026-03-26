import 'dart:developer';
class BaseState<T> {
  bool isLoading = false;
  String? errorMessage;
  T? data;

  BaseState({this.isLoading = false, this.errorMessage, this.data});

  BaseState<T> copyWith({
    bool? isLoading,
    String? errorMessage,
    T? data,
  }) {
    return BaseState<T>(
      isLoading:isLoading?? this.isLoading,
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
