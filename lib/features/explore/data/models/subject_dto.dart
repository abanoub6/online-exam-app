import 'package:equatable/equatable.dart';

class SubjectDto extends Equatable {
  final String? id;
  final String? name;
  final String? icon;
  final String? createdAt;

  const SubjectDto({this.id, this.name, this.icon, this.createdAt});

  factory SubjectDto.fromJson(Map<String, dynamic> json) {
    return SubjectDto(
      id: json['_id'] as String?,
      name: json['name'] as String?,
      icon: json['icon'] as String?,
      createdAt: json['createdAt'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
    '_id': id,
    'name': name,
    'icon': icon,
    'createdAt': createdAt,
  };

  @override
  List<Object?> get props => [id, name, icon, createdAt];
}
