class ExamEntity {
  final String id;
  final String title;
  final int duration;
  final String subject;
  final int numberOfQuestions;
  final bool active;
  final DateTime createdAt;

  const ExamEntity({
    required this.id,
    required this.title,
    required this.duration,
    required this.subject,
    required this.numberOfQuestions,
    required this.active,
    required this.createdAt,
  });
}

// ============================

class MetadataEntity {
  final int currentPage;
  final int numberOfPages;
  final int limit;

  const MetadataEntity({
    required this.currentPage,
    required this.numberOfPages,
    required this.limit,
  });
}

// ============================

class ExamResponseEntity {
  final String message;
  final MetadataEntity metadata;
  final List<ExamEntity> exams;

  const ExamResponseEntity({
    required this.message,
    required this.metadata,
    required this.exams,
  });
}