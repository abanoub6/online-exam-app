import 'package:equatable/equatable.dart';

sealed class ExamsEvents extends Equatable {
  const ExamsEvents();
}

class GetAllExamsEvent extends ExamsEvents {
  const GetAllExamsEvent();

  @override
  List<Object?> get props => [];
}

class GetExamsBySubjectEvent extends ExamsEvents {
  final String subjectId;
  const GetExamsBySubjectEvent(this.subjectId);

  @override
  List<Object?> get props => [subjectId];
}
