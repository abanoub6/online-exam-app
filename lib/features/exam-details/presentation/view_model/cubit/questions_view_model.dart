import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam_app_v/config/base_responce/base_response.dart';
import 'package:online_exam_app_v/features/exam-details/data/models/socre_result.dart';
import 'package:online_exam_app_v/features/exam-details/domain/entities/question_entity.dart';
import 'package:online_exam_app_v/features/exam-details/domain/use_cases/get_questions_on_exam_use_case.dart';
import 'package:online_exam_app_v/features/exam-details/presentation/view_model/states/questions_events.dart';
import 'package:online_exam_app_v/features/exam-details/presentation/view_model/states/questions_states.dart';

@injectable
class QuestionsViewModel extends Cubit<QuestionsStates> {
  final GetQuestionsOnExamUseCase getQuestionsOnExamUseCase;

  QuestionsViewModel(this.getQuestionsOnExamUseCase) : super(QuestionsStates());

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

      case CalculateScoreEvent():
        // يمكن إرجاع الـ Score عبر State لو احتجت
        break;

      case ClearAnswersEvent():
        _clearAnswers();
        break;

      case CanGoNextEvent():
        // يمكنك إضافة Logic إضافي هنا لو احتجت
        break;
    }
  }

  // ====================== Private Methods ======================

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

  ScoreResult _calculateScore() {
    final questions = state.questionsState.data ?? [];

    if (questions.isEmpty) {
      return ScoreResult(
        correctAnswers: 0,
        totalQuestions: 0,
        scorePercentage: 0.0,
      );
    }

    int correctCount = 0;
    for (var question in questions) {
      final userAnswer = _userAnswers[question.id];
      if (userAnswer != null && userAnswer == question.correctAnswerKey) {
        correctCount++;
      }
    }

    final total = questions.length;
    final percentage = (correctCount / total) * 100;

    return ScoreResult(
      correctAnswers: correctCount,
      totalQuestions: total,
      scorePercentage: percentage,
    );
  }

  void _clearAnswers() {
    _userAnswers.clear();
  }

  bool _canGoNext(String questionId) {
    return _userAnswers.containsKey(questionId) &&
        _userAnswers[questionId] != null &&
        _userAnswers[questionId]!.isNotEmpty;
  }

  // ====================== Public Helpers (للـ UI فقط) ======================
  String? getSelectedAnswer(String questionId) => _userAnswers[questionId];

  bool isAnswerSelected(String questionId, String answerKey) =>
      _userAnswers[questionId] == answerKey;

  int getAnsweredQuestionsCount() => _userAnswers.length;

  bool canGoNext(String questionId) => _canGoNext(questionId);

  ScoreResult calculateScore() => _calculateScore();

  @override
  Future<void> close() {
    _userAnswers.clear();
    return super.close();
  }
}
