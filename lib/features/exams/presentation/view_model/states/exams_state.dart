import 'package:equatable/equatable.dart';
import 'package:online_exam_app_v/features/exams/domain/models/exam_entity.dart';

sealed class ExamsState extends Equatable {
  const ExamsState();
}

class ExamsInitial extends ExamsState {
  const ExamsInitial();

  @override
  List<Object?> get props => [];
}

class ExamsLoading extends ExamsState {
  const ExamsLoading();

  @override
  List<Object?> get props => [];
}

class ExamsSuccess extends ExamsState {
  final List<ExamEntity> exams;
  const ExamsSuccess(this.exams);

  @override
  List<Object?> get props => [exams];
}

class ExamsFailure extends ExamsState {
  final String errorMessage;
  const ExamsFailure(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}
