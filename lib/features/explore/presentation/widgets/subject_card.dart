import 'package:flutter/material.dart';
import 'package:online_exam_app_v/core/theme/app_colors.dart';
import 'package:online_exam_app_v/core/theme/app_sizes.dart';
import 'package:online_exam_app_v/core/theme/app_text_styles.dart';
import 'package:online_exam_app_v/features/exam-details/presentation/screens/exam_details_screen.dart';
import 'package:online_exam_app_v/features/exams/presentation/screens/exams_screen.dart';
import 'package:online_exam_app_v/features/explore/domain/entities/subject.dart';

class SubjectCard extends StatelessWidget {
  const SubjectCard(this.subject, {super.key});

  final Subject subject;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          ExamsScreen.routeName,
          arguments: subject.id,
        );
      },
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: AppSizes.w(16),
          vertical: AppSizes.h(8),
        ),
        child: Container(
          padding: EdgeInsets.all(AppSizes.h(12)),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(AppSizes.r(12)),
            boxShadow: [
              BoxShadow(
                color: AppColors.black.withOpacity(0.3),
                blurRadius: AppSizes.r(8),
                offset: const Offset(0, 1),
              ),
            ],
          ),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(AppSizes.r(8)),
                child: Image.network(
                  subject.icon,
                  width: AppSizes.w(48),
                  height: AppSizes.h(48),
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Container(
                      width: AppSizes.w(48),
                      height: AppSizes.h(48),
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(AppSizes.r(8)),
                      ),
                    );
                  },
                  errorBuilder: (_, __, ___) => const Icon(Icons.image),
                ),
              ),
              SizedBox(width: AppSizes.w(16)),
              Text(subject.name, style: AppTextStyles.s16w400()),
            ],
          ),
        ),
      ),
    );
  }
}
