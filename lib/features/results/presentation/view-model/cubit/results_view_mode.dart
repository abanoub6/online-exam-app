import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam_app_v/features/results/domain/use-cases/get_exam_results_use_case.dart';
import 'package:online_exam_app_v/features/results/presentation/view-model/states/results_events.dart';
import 'package:online_exam_app_v/features/results/presentation/view-model/states/results_states.dart';

@injectable
class ResultsViewModel extends Cubit<ResultsStates> {
  final GetExamResultsUseCase getExamResultsUseCase;

  ResultsViewModel(this.getExamResultsUseCase) : super(ResultsStates());

  void doEvent(ResultsEvents event) {
    switch (event) {
      case LoadResultsEvent():
        _loadResults();
        break;

      case ClearResultsEvent():
        _clearResults();
        break;

      case ClearErrorEvent():
        _clearError();
        break;
    }
  }

  // ================= PRIVATE =================

  Future<void> _loadResults() async {
    emit(
      state.copyWith(
        resultsStateParam: state.resultsState.copyWith(
          isLoadingParam: true,
          errorMessageParam: null,
        ),
      ),
    );

    try {
      final results = getExamResultsUseCase();

      emit(
        state.copyWith(
          resultsStateParam: state.resultsState.copyWith(
            isLoadingParam: false,
            dataParam: results,
          ),
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          resultsStateParam: state.resultsState.copyWith(
            isLoadingParam: false,
            errorMessageParam: e.toString(),
          ),
        ),
      );
    }
  }

  void _clearResults() {
    emit(
      state.copyWith(
        resultsStateParam: state.resultsState.copyWith(dataParam: []),
      ),
    );
  }

  void _clearError() {
    emit(
      state.copyWith(
        resultsStateParam: state.resultsState.copyWith(errorMessageParam: null),
      ),
    );
  }
}
