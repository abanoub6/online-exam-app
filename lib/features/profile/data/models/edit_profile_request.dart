import 'package:equatable/equatable.dart';

class EditProfileRequest extends Equatable {
  final String? username;
  final String? firstName;
  final String? lastName;
  final String? phone;

  const EditProfileRequest({
    this.username,
    this.firstName,
    this.lastName,
    this.phone,
  });

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (username != null) map['username'] = username;
    if (firstName != null) map['firstName'] = firstName;
    if (lastName != null) map['lastName'] = lastName;
    if (phone != null) map['phone'] = phone;
    return map;
  }

  @override
  List<Object?> get props => [username, firstName, lastName, phone];
}
