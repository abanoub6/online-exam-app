import 'package:flutter/material.dart';
import 'package:online_exam_app_v/core/theme/app_colors.dart';
import 'package:online_exam_app_v/features/exam-details/data/models/socre_result.dart';
import 'package:online_exam_app_v/features/exam-details/presentation/screens/score_screen.dart';

class ShowTimeOutDialog extends StatelessWidget {
  final ScoreResult score;
  const ShowTimeOutDialog({super.key, required this.score});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.timer_off, size: 60, color: Colors.red),
            const SizedBox(height: 16),
            const Text(
              "Time out !!",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(
                    context,
                    ScoreScreen.routeName,
                    arguments: {
                      "correct": score.correctAnswers,
                      "incorrect": score.totalQuestions - score.correctAnswers,
                      "percentage": score.scorePercentage,
                    },
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.blue,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(28),
                  ),
                ),
                child: const Text("View Score", style: TextStyle(fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
