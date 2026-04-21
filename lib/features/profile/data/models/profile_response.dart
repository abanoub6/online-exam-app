import 'package:equatable/equatable.dart';
import 'package:online_exam_app_v/features/profile/domain/entities/profile_entity.dart';

class ProfileResponse extends Equatable {
  final String message;
  final UserData user;

  const ProfileResponse({required this.message, required this.user});

  factory ProfileResponse.fromJson(Map<String, dynamic> json) =>
      ProfileResponse(
        message: json['message'] ?? '',
        user: UserData.fromJson(json['user']),
      );

  @override
  List<Object?> get props => [message, user];
}

class UserData extends Equatable {
  final String id;
  final String username;
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final String role;
  final bool isVerified;
  final String createdAt;
  final bool resetCodeVerified;

  const UserData({
    required this.id,
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.role,
    required this.isVerified,
    required this.createdAt,
    required this.resetCodeVerified,
  });

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
    id: json['_id'] ?? '',
    username: json['username'] ?? '',
    firstName: json['firstName'] ?? '',
    lastName: json['lastName'] ?? '',
    email: json['email'] ?? '',
    phone: json['phone'] ?? '',
    role: json['role'] ?? '',
    isVerified: json['isVerified'] ?? false,
    createdAt: json['createdAt'] ?? '',
    resetCodeVerified: json['resetCodeVerified'] ?? false,
  );

  ProfileEntity toEntity() => ProfileEntity(
    id: id,
    username: username,
    firstName: firstName,
    lastName: lastName,
    email: email,
    phone: phone,
    role: role,
    isVerified: isVerified,
    createdAt: createdAt,
    resetCodeVerified: resetCodeVerified,
  );

  @override
  List<Object?> get props => [
    id,
    username,
    firstName,
    lastName,
    email,
    phone,
    role,
    isVerified,
    createdAt,
    resetCodeVerified,
  ];
}
