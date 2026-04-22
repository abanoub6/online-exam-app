import 'package:equatable/equatable.dart';

class Subject extends Equatable {
  final String id;
  final String name;
  final String icon;

  const Subject({required this.id, required this.name, required this.icon});

  @override
  List<Object?> get props => [id, name, icon];
}
