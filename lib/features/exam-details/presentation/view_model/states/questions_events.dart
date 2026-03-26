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
