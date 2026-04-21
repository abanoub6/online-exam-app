import 'package:equatable/equatable.dart';

class ChangePasswordRequest extends Equatable {
  final String oldPassword;
  final String password;
  final String rePassword;

  const ChangePasswordRequest({
    required this.oldPassword,
    required this.password,
    required this.rePassword,
  });

  Map<String, dynamic> toJson() => {
    'oldPassword': oldPassword,
    'password': password,
    'rePassword': rePassword,
  };

  @override
  List<Object?> get props => [oldPassword, password, rePassword];
}
