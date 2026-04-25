import 'package:flutter/material.dart';
import 'package:online_exam_app_v/features/results/domain/enties/exam_result_entity.dart';

class ResultCardWidget extends StatelessWidget {
  final ExamResultEntity result;
  final VoidCallback onTap;

  const ResultCardWidget({
    super.key,
    required this.result,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              const Icon(Icons.assignment, size: 40),

              const SizedBox(width: 16),

              /// 🔥 Middle section
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      result.examTitle,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 4),

                    Text("${result.totalQuestions} Questions"),

                    const SizedBox(height: 4),

                    Text(
                      "${result.correctAnswers} correct answers",
                      style: const TextStyle(color: Colors.blue),
                    ),
                  ],
                ),
              ),

              /// 🔥 Right section
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text("30 Minutes"),

                  const SizedBox(height: 8),

                  Text(
                    "${result.percentage.toStringAsFixed(1)}%",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
