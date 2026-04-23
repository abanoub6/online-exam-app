import 'package:online_exam_app_v/config/base_state/base_state.dart';
import 'package:online_exam_app_v/features/exams/domain/models/exam_entity.dart';

class ExamsStates {
  BaseState<List<ExamEntity>> examsState = BaseState<List<ExamEntity>>(
    isLoading: false,
  );

  ExamsStates({BaseState<List<ExamEntity>>? examsState}) {
    this.examsState =
        examsState ?? BaseState<List<ExamEntity>>(isLoading: false);
  }

  ExamsStates copyWith({BaseState<List<ExamEntity>>? examsStateParam}) {
    return ExamsStates(examsState: examsStateParam ?? examsState);
  }
}
