import 'package:flutter/material.dart';
import 'package:online_exam_app_v/core/theme/app_colors.dart';
import 'package:online_exam_app_v/core/theme/app_text_styles.dart';
import 'package:online_exam_app_v/features/results/domain/enties/exam_result_entity.dart';

class ResultsDetailsScreen extends StatelessWidget {
  static const routeName = "results-details";

  const ResultsDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final result =
        ModalRoute.of(context)!.settings.arguments as ExamResultEntity;

    return Scaffold(
      appBar: AppBar(title: Text(result.examTitle)),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: result.questions.length,
        itemBuilder: (context, index) {
          final q = result.questions[index];

          return Card(
            color: AppColors.white,
            elevation: 5,
            margin: const EdgeInsets.only(bottom: 16),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (q.selectedAnswer == null)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Text(
                        "Not Answered",
                        style: AppTextStyles.s14w500(Colors.orange),
                      ),
                    ),

                  Text(
                    "Q${index + 1}: ${q.question}",
                    style: AppTextStyles.s18Bold(),
                  ),

                  const SizedBox(height: 10),

                  ...q.answers.map((a) {
                    final isCorrect = a.key == q.correctAnswerKey;
                    final isSelected = a.key == q.selectedAnswer;

                    return Container(
                      margin: const EdgeInsets.only(bottom: 6),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: isCorrect
                            ? Colors.green.withValues(alpha: 0.2)
                            : isSelected
                            ? Colors.red.withValues(alpha: 0.2)
                            : Colors.white,
                        border: Border.all(
                          color: isCorrect
                              ? Colors.green
                              : isSelected
                              ? Colors.red
                              : Colors.grey,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            isCorrect
                                ? Icons.check_box
                                : isSelected
                                ? Icons.close
                                : Icons.check_box_outline_blank_rounded,
                            color: isCorrect
                                ? AppColors.green
                                : isSelected
                                ? AppColors.red
                                : AppColors.blue,
                          ),
                          const SizedBox(width: 8),
                          Expanded(child: Text(a.answer)),
                        ],
                      ),
                    );
                  }),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
