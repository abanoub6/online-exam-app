import 'package:equatable/equatable.dart';
import 'package:online_exam_app_v/features/explore/data/models/subject_dto.dart';

class SubjectResponseModel extends Equatable {
  final String? message;
  final List<SubjectDto?>? subjects;

  const SubjectResponseModel({this.message, this.subjects});

  factory SubjectResponseModel.fromJson(Map<String, dynamic> json) {
    return SubjectResponseModel(
      message: json['message'] as String?,
      subjects: (json['subjects'] as List<dynamic>?)
          ?.map(
            (e) => e == null
                ? null
                : SubjectDto.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    'message': message,
    'subjects': subjects?.map((e) => e?.toJson()).toList(),
  };

  @override
  List<Object?> get props => [message, subjects];
}
