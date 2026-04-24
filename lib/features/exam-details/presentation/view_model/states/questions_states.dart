import 'package:online_exam_app_v/config/base_state/base_state.dart';
import 'package:online_exam_app_v/features/exam-details/domain/entities/question_entity.dart';

class QuestionsStates {
  BaseState<List<QuestionEntity>> questionsState =
      BaseState<List<QuestionEntity>>();

  // لحفظ إجابات المستخدم (questionId → selectedAnswerKey)
  final Map<String, String> userAnswers = {};

  QuestionsStates({
    BaseState<List<QuestionEntity>>? questionsStateParam,
    Map<String, String>? userAnswersParam,
  }) {
    questionsState = questionsStateParam ?? BaseState<List<QuestionEntity>>();
    if (userAnswersParam != null) {
      userAnswers.addAll(userAnswersParam);
    }
  }

  QuestionsStates copyWith({
    BaseState<List<QuestionEntity>>? questionsStateParam,
    Map<String, String>? userAnswersParam,
  }) {
    return QuestionsStates(
      questionsStateParam: questionsStateParam ?? questionsState,
      userAnswersParam: userAnswersParam ?? Map.from(userAnswers),
    );
  }
}
