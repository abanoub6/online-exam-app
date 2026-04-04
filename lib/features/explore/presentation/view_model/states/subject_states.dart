import 'package:online_exam_app_v/features/explore/domain/entities/subject.dart';

abstract class SubjectState {}

class SubjectInitial extends SubjectState {}

class GetSubjectLoading extends SubjectState {}

class GetSubjectSuccess extends SubjectState {
  final List<Subject> subject;

  GetSubjectSuccess(this.subject);
}

class GetSubjectError extends SubjectState {
  final String message;
  GetSubjectError(this.message);
}
