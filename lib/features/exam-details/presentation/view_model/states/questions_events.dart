import 'package:online_exam_app_v/features/exam-details/data/models/socre_result.dart';

sealed class QuestionsEvents {}

class GetQuestionsOnExamEvent extends QuestionsEvents {
  final String examId;
  GetQuestionsOnExamEvent(this.examId);
}

class SaveExamResults extends QuestionsEvents {
  final ScoreResult score;
  SaveExamResults(this.score);
}

class SelectAnswerEvent extends QuestionsEvents {
  final String questionId;
  final String selectedAnswerKey;

  SelectAnswerEvent({
    required this.questionId,
    required this.selectedAnswerKey,
  });
}

class ClearQuestionsErrorEvent extends QuestionsEvents {}

// // Timer Events
// class StartTimerEvent extends QuestionsEvents {}

// class TimeFinishedEvent extends QuestionsEvents {}

class ClearAnswersEvent extends QuestionsEvents {}

class CanGoNextEvent extends QuestionsEvents {
  final String questionId;
  CanGoNextEvent(this.questionId);
}
