import 'package:flutter/material.dart';
import 'package:online_exam_app_v/core/theme/app_colors.dart';
import 'package:online_exam_app_v/core/theme/app_sizes.dart';
import 'package:online_exam_app_v/core/theme/app_text_styles.dart';
import 'package:online_exam_app_v/core/widgets/primary_button.dart';

class ScoreScreen extends StatelessWidget {
  static const String routeName = "score-screen";

  const ScoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;

    final int correct = args["correct"];
    final int incorrect = args["incorrect"];
    final double percentage = args["percentage"];
    return Scaffold(
      appBar: AppBar(
        title: Text("Exam score", style: AppTextStyles.s20w600()),
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
            Text("Your score", style: AppTextStyles.s18w600()),

            SizedBox(height: AppSizes.h(24)),

            Row(
              children: [
                // 🔵 Circular Progress
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

                // 📊 Stats
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildStatRow(
                      label: "Correct",
                      value: correct,
                      color: AppColors.blue,
                    ),
                    SizedBox(height: AppSizes.h(12)),
                    _buildStatRow(
                      label: "Incorrect",
                      value: incorrect,
                      color: Colors.red,
                    ),
                  ],
                ),
              ],
            ),

            const Spacer(),

            // 🔵 Show Results Button
            Row(
              children: [
                Expanded(
                  child: PrimaryButton(
                    onPressed: () {
                      // ممكن تروح لصفحة تفصيل الإجابات
                    },
                    text: "Show results",
                  ),
                ),
              ],
            ),

            SizedBox(height: AppSizes.h(16)),

            // 🔄 Start Again
            OutlinedButton(
              onPressed: () {
                Navigator.pop(context); //  تعيد الامتحان
              },
              style: OutlinedButton.styleFrom(
                minimumSize: Size(double.infinity, AppSizes.h(56)),
                side: const BorderSide(color: AppColors.blue),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(28),
                ),
              ),
              child: Text(
                "Start again",
                style: AppTextStyles.s16w600(AppColors.blue),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatRow({
    required String label,
    required int value,
    required Color color,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(label, style: AppTextStyles.s16w500(color)),
        SizedBox(width: AppSizes.w(12)),
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: color),
          ),
          child: Text(
            value.toString(),
            style: TextStyle(color: color, fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }
}
