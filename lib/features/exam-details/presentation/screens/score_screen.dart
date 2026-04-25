import 'package:flutter/material.dart';
import 'package:online_exam_app_v/core/constants/app_strings.dart';
import 'package:online_exam_app_v/core/theme/app_colors.dart';
import 'package:online_exam_app_v/core/theme/app_sizes.dart';
import 'package:online_exam_app_v/core/theme/app_text_styles.dart';
import 'package:online_exam_app_v/core/widgets/primary_button.dart';
import 'package:online_exam_app_v/features/exam-details/presentation/screens/exam_details_screen.dart';
import 'package:online_exam_app_v/features/exam-details/presentation/widgets/build_state_row.dart';
import 'package:online_exam_app_v/features/results/presentation/screens/results_screen.dart';

class ScoreScreen extends StatelessWidget {
  final int correct;
  final int incorrect;
  final double percentage;

  final String examId;
  final String examTitle;

  const ScoreScreen({
    super.key,
    required this.correct,
    required this.incorrect,
    required this.percentage,
    required this.examId,
    required this.examTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.examScore, style: AppTextStyles.s20w600()),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),

      body: Padding(
        padding: EdgeInsets.all(AppSizes.w(24)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Title
            Text(AppStrings.yourScore, style: AppTextStyles.s18w600()),

            SizedBox(height: AppSizes.h(24)),

            /// Score + Stats
            Row(
              children: [
                /// Circular Progress
                Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      width: 120,
                      height: 120,
                      child: CircularProgressIndicator(
                        value: percentage / 100,
                        strokeWidth: 6,
                        backgroundColor: AppColors.red,
                        color: AppColors.blue,
                      ),
                    ),
                    Text(
                      "${percentage.toInt()}%",
                      style: AppTextStyles.s20w700(),
                    ),
                  ],
                ),

                SizedBox(width: AppSizes.w(40)),

                /// Stats
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BuildStateRow(
                      label: AppStrings.correct,
                      value: correct,
                      color: AppColors.blue,
                    ),
                    SizedBox(height: AppSizes.h(12)),
                    BuildStateRow(
                      label: AppStrings.incorrect,
                      value: incorrect,
                      color: Colors.red,
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 70),

            /// 🔥 Show Results Button (زي ما هو)
            Row(
              children: [
                Expanded(
                  child: PrimaryButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(
                        context,
                        ResultsScreen.routeName,
                      );
                    },
                    text: AppStrings.showResults,
                  ),
                ),
              ],
            ),

            SizedBox(height: AppSizes.h(16)),

            OutlinedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        ExamDetailsScreen(examId: examId, examTitle: examTitle),
                  ),
                );
              },
              style: OutlinedButton.styleFrom(
                minimumSize: Size(double.infinity, AppSizes.h(56)),
                side: const BorderSide(color: AppColors.blue),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(28),
                ),
              ),
              child: Text(
                AppStrings.startAgain,
                style: AppTextStyles.s16w600(AppColors.blue),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
