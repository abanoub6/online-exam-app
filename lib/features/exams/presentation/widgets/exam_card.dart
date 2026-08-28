import 'package:flutter/material.dart';
import 'package:online_exam_app_v/core/constants/app_strings.dart';
import 'package:online_exam_app_v/core/theme/app_colors.dart';
import 'package:online_exam_app_v/core/theme/app_sizes.dart';
import 'package:online_exam_app_v/core/theme/app_text_styles.dart';
import 'package:online_exam_app_v/features/exams/domain/models/exam_entity.dart';
import 'package:online_exam_app_v/features/exams/presentation/screens/exam_start_screen.dart';

class ExamCard extends StatelessWidget {
  final ExamEntity exam;
  const ExamCard({super.key, required this.exam});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: AppSizes.h(12)),
      child: InkWell(
        onTap: () => Navigator.pushNamed(
          context,
          ExamStartScreen.routeName,
          arguments: exam,
        ),
        borderRadius: BorderRadius.circular(AppSizes.r(12)),
        child: Container(
          padding: EdgeInsets.all(AppSizes.h(16)),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(AppSizes.r(10)),
            boxShadow: [
              BoxShadow(
                color: AppColors.black.withValues(alpha: 0.1),
                blurRadius: AppSizes.r(8),
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(AppSizes.r(8)),
                child: Image.asset(
                  AppStrings.assetsIconsProfit,
                  width: AppSizes.w(60),
                  height: AppSizes.h(70),
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: AppSizes.w(12)),
              Expanded(
                // FittedBox only shrinks the content if it doesn't fit the
                // Row's height constraint — on mobile, where it already
                // fits, this changes nothing visually. On web, where
                // AppSizes' scaling leaves slightly less room, this
                // prevents the overflow stripes automatically.
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        exam.title,
                        style: AppTextStyles.s16w500(AppColors.black),
                      ),
                      // SizedBox(height: AppSizes.h(2)),
                      Text(
                        '${exam.numberOfQuestions} ${AppStrings.question}',
                        style: AppTextStyles.s14w400(AppColors.gray),
                      ),
                      SizedBox(height: AppSizes.h(10)),
                      Text(
                        AppStrings.from1To6,
                        style: AppTextStyles.s14w400(AppColors.black),
                      ),
                    ],
                  ),
                ),
              ),
              Text(
                '${exam.duration} ${AppStrings.minutes}',
                style: AppTextStyles.s14w400(AppColors.blue),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
