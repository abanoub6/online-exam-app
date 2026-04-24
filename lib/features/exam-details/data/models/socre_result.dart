class ScoreResult {
  final int correctAnswers;
  final int totalQuestions;
  final double scorePercentage;

  ScoreResult({
    required this.correctAnswers,
    required this.totalQuestions,
    required this.scorePercentage,
  });

  String get percentageString => "${scorePercentage.toStringAsFixed(1)}%";
}
