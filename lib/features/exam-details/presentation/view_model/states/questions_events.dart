sealed class QuestionsEvents {}

class GetQuestionsOnExamEvent extends QuestionsEvents {
  final String examId;
  GetQuestionsOnExamEvent(this.examId);
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

// Score & Navigation Events
class CalculateScoreEvent extends QuestionsEvents {}

class ClearAnswersEvent extends QuestionsEvents {}

class CanGoNextEvent extends QuestionsEvents {
  final String questionId;
  CanGoNextEvent(this.questionId);
}
