import 'package:equatable/equatable.dart';
import 'package:online_exam_app_v/features/login/domain/entities/user_entity.dart';

class UserModel extends Equatable {
  final String id;
  final String username;
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final String role;
  final bool isVerified;
  final String createdAt;

  const UserModel({
    required this.id,
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.role,
    required this.isVerified,
    required this.createdAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json['_id'] ?? '',
    username: json['username'] ?? '',
    firstName: json['firstName'] ?? '',
    lastName: json['lastName'] ?? '',
    email: json['email'] ?? '',
    phone: json['phone'] ?? '',
    role: json['role'] ?? '',
    isVerified: json['isVerified'] ?? false,
    createdAt: json['createdAt'] ?? '',
  );

  UserEntity toEntity() => UserEntity(
    id: id,
    username: username,
    firstName: firstName,
    lastName: lastName,
    email: email,
    phone: phone,
    role: role,
    isVerified: isVerified,
    createdAt: createdAt,
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
  ];
}
