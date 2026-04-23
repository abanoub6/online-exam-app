import 'package:flutter/material.dart';
import 'package:online_exam_app_v/core/theme/app_colors.dart';
import 'package:online_exam_app_v/core/theme/app_sizes.dart';
import 'package:online_exam_app_v/core/theme/app_text_styles.dart';
import 'package:online_exam_app_v/core/widgets/primary_button.dart';
import 'package:online_exam_app_v/features/exam-details/presentation/screens/exam_details_screen.dart';
import 'package:online_exam_app_v/features/exams/domain/models/exam_entity.dart';

class ExamStartScreen extends StatelessWidget {
  static const String routeName = "exam-start-screen";
  const ExamStartScreen({super.key});

  static const List<String> _instructions = [
    'Lorem ipsum dolor sit amet consectetur.',
    'Lorem ipsum dolor sit amet consectetur.',
    'Lorem ipsum dolor sit amet consectetur.',
    'Lorem ipsum dolor sit amet consectetur.',
  ];

  @override
  Widget build(BuildContext context) {
    final exam = ModalRoute.of(context)!.settings.arguments as ExamEntity;

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: AppColors.black,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppSizes.w(16)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: AppSizes.h(16)),

            // Exam header
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(AppSizes.r(8)),
                  child: Image.asset(
                    "assets/icons/Profit.png",
                    width: AppSizes.w(42),
                    height: AppSizes.h(46),
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(width: AppSizes.w(12)),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            exam.title,
                            style: AppTextStyles.s18w500(AppColors.black),
                          ),
                          Text(
                            '${exam.duration} Minutes',
                            style: AppTextStyles.s12w400(AppColors.blue),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: AppSizes.h(16)),
            Row(
              children: [
                Text(
                  'High level',
                  style: AppTextStyles.s18w500(AppColors.black),
                ),
                SizedBox(width: AppSizes.w(2)),
                SizedBox(
                  height: AppSizes.h(20),
                  child: VerticalDivider(thickness: 0.5, color: AppColors.blue),
                ),
                SizedBox(width: AppSizes.w(2)),
                Text(
                  '${exam.numberOfQuestions} Question',
                  style: AppTextStyles.s16w400(AppColors.gray),
                ),
              ],
            ),

            SizedBox(height: AppSizes.h(10)),

            Divider(thickness: 0.5, color: AppColors.blue),

            SizedBox(height: AppSizes.h(20)),

            // Instructions
            Text('Instructions', style: AppTextStyles.s18w500(AppColors.black)),
            SizedBox(height: AppSizes.h(16)),

            // Instructions list
            ...(_instructions.map(
              (instruction) => Padding(
                padding: EdgeInsets.only(bottom: AppSizes.h(8)),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('• ', style: AppTextStyles.s14w400(AppColors.black)),
                    Expanded(
                      child: Text(
                        instruction,
                        style: AppTextStyles.s14w400(AppColors.black),
                      ),
                    ),
                  ],
                ),
              ),
            )),

            const SizedBox(height: 32),

            // Start button
            SizedBox(
              width: double.infinity,
              height: AppSizes.h(52),
              child: PrimaryButton(
                text: 'Start',
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    ExamDetailsScreen.routeName,
                    arguments: exam.id,
                  );
                },
              ),
            ),
            SizedBox(height: AppSizes.h(24)),
          ],
        ),
      ),
    );
  }
}
