import 'package:online_exam_app_v/config/base_state/base_state.dart';
import 'package:online_exam_app_v/features/exams/domain/models/exam_entity.dart';

class ExamsState {
  BaseState<List<ExamEntity>> examListState = BaseState<List<ExamEntity>>(
    isLoading: true,
    data: [],
  );

  
}
