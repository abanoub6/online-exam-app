import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam_app_v/config/base_responce/base_response.dart';
import 'package:online_exam_app_v/features/exam-details/domain/entities/question_entity.dart';
import 'package:online_exam_app_v/features/exam-details/domain/use_cases/get_questions_on_exam_use_case.dart';
import 'package:online_exam_app_v/features/exam-details/presentation/view_model/states/questions_events.dart';
import 'package:online_exam_app_v/features/exam-details/presentation/view_model/states/questions_states.dart';

@singleton
class QuestionsViewModel extends Cubit<QuestionsStates> {
  final GetQuestionsOnExamUseCase getQuestionsOnExamUseCase;

  QuestionsViewModel(this.getQuestionsOnExamUseCase) : super(QuestionsStates());

  // لتخزين الإجابات المختارة
  final Map<String, String> _userAnswers = {};

  void doEvent(QuestionsEvents event) {
    switch (event) {
      case GetQuestionsOnExamEvent():
        _getQuestionsOnExam(event.examId);
        break;

      case SelectAnswerEvent():
        _selectAnswer(event.questionId, event.selectedAnswerKey);
        break;

      case ClearQuestionsErrorEvent():
        _clearError();
        break;
    }
  }

  Future<void> _getQuestionsOnExam(String examId) async {
    emit(
      state.copyWith(
        questionsStateParam: state.questionsState.copyWith(
          isLoadingParam: true,
          errorMessageParam: null,
        ),
      ),
    );

    final response = await getQuestionsOnExamUseCase(examId);

    switch (response) {
      case SuccessBaseResponse<List<QuestionEntity>>():
        emit(
          state.copyWith(
            questionsStateParam: state.questionsState.copyWith(
              isLoadingParam: false,
              dataParam: response.data,
            ),
          ),
        );
        break;

      case ErrorBaseResponse<List<QuestionEntity>>():
        emit(
          state.copyWith(
            questionsStateParam: state.questionsState.copyWith(
              isLoadingParam: false,
              errorMessageParam: response.errorMessage,
            ),
          ),
        );
        break;
    }
  }

  void _selectAnswer(String questionId, String selectedAnswerKey) {
    _userAnswers[questionId] = selectedAnswerKey;

    emit(state.copyWith(userAnswersParam: Map.from(_userAnswers)));
  }

  void _clearError() {
    emit(
      state.copyWith(
        questionsStateParam: state.questionsState.copyWith(
          errorMessageParam: null,
        ),
      ),
    );
  }

  // Helper methods
  String? getSelectedAnswer(String questionId) {
    return _userAnswers[questionId];
  }

  bool isAnswerSelected(String questionId, String answerKey) {
    return _userAnswers[questionId] == answerKey;
  }

  int getAnsweredQuestionsCount() {
    return _userAnswers.length;
  }

  @override
  Future<void> close() {
    _userAnswers.clear();
    return super.close();
  }
}
