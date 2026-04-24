import 'package:online_exam_app_v/config/base_state/base_state.dart';
import 'package:online_exam_app_v/features/results/domain/enties/exam_result_entity.dart';

class ResultsStates {
  BaseState<List<ExamResultEntity>> resultsState =
      BaseState<List<ExamResultEntity>>();

  ResultsStates({BaseState<List<ExamResultEntity>>? resultsStateParam}) {
    resultsState = resultsStateParam ?? BaseState<List<ExamResultEntity>>();
  }

  ResultsStates copyWith({
    BaseState<List<ExamResultEntity>>? resultsStateParam,
  }) {
    return ResultsStates(resultsStateParam: resultsStateParam ?? resultsState);
  }
}
