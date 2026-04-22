import 'package:equatable/equatable.dart';
import 'package:online_exam_app_v/features/explore/domain/entities/subject.dart';

abstract class SubjectState extends Equatable {
  const SubjectState();
}

class SubjectInitial extends SubjectState {
  const SubjectInitial();

  @override
  List<Object?> get props => [];
}

class GetSubjectLoading extends SubjectState {
  const GetSubjectLoading();

  @override
  List<Object?> get props => [];
}

class GetSubjectSuccess extends SubjectState {
  final List<Subject> subject;

  const GetSubjectSuccess(this.subject);

  @override
  List<Object?> get props => [subject];
}

class GetSubjectError extends SubjectState {
  final String message;

  const GetSubjectError(this.message);

  @override
  List<Object?> get props => [message];
}
