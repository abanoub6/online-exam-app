import 'package:flutter/material.dart';
import 'package:online_exam_app_v/core/constants/app_strings.dart';
import 'package:online_exam_app_v/core/theme/app_colors.dart';
import 'package:online_exam_app_v/core/theme/app_text_styles.dart';
import 'package:online_exam_app_v/features/exam-details/data/models/socre_result.dart';
import 'package:online_exam_app_v/features/exam-details/presentation/screens/score_screen.dart';

class ShowTimeOutDialog extends StatelessWidget {
  final ScoreResult score;
  final String examId;
  final String examTitle;

  const ShowTimeOutDialog({
    super.key,
    required this.score,
    required this.examId,
    required this.examTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                const ImageIcon(
                  size: 50,
                  AssetImage("assets/icons/time_out_iocn.png"),
                  color: Colors.grey,
                ),
                const SizedBox(width: 16),
                const Text(
                  AppStrings.timeOut,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  /// اقفل الديالوج
                  Navigator.pop(context);

                  /// روح للـ score screen (replace)
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ScoreScreen(
                        correct: score.correctAnswers,
                        incorrect: score.totalQuestions - score.correctAnswers,
                        percentage: score.scorePercentage,
                        examId: examId,
                        examTitle: examTitle,
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.blue,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(28),
                  ),
                ),
                child: Text(
                  AppStrings.viewSocre,
                  style: AppTextStyles.s16w500(AppColors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
