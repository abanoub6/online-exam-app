import 'package:equatable/equatable.dart';
import 'package:online_exam_app_v/config/base_state/base_state.dart';
import 'package:online_exam_app_v/features/exams/domain/models/exam_entity.dart';

class ExamsState extends Equatable {
  final BaseState<List<ExamEntity>> examsState;

  ExamsState({BaseState<List<ExamEntity>>? examsState})
    : examsState = examsState ?? BaseState<List<ExamEntity>>(isLoading: false);

  ExamsState copyWith({BaseState<List<ExamEntity>>? examsStateParam}) {
    return ExamsState(examsState: examsStateParam ?? examsState);
  }

  @override
  List<Object?> get props => [examsState];
}
