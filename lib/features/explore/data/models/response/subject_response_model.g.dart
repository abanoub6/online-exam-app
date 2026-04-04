// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subject_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubjectResponseModel _$SubjectResponseModelFromJson(
  Map<String, dynamic> json,
) => SubjectResponseModel(
  json['message'] as String?,
  (json['subjects'] as List<dynamic>?)
      ?.map(
        (e) =>
            e == null ? null : SubjectDto.fromJson(e as Map<String, dynamic>),
      )
      .toList(),
);

Map<String, dynamic> _$SubjectResponseModelToJson(
  SubjectResponseModel instance,
) => <String, dynamic>{
  'message': instance.message,
  'subjects': instance.subjects,
};
