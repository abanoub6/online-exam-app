import 'package:flutter/material.dart';
import 'package:online_exam_app_v/core/theme/app_colors.dart';
import 'package:online_exam_app_v/core/theme/app_text_styles.dart';
import 'package:online_exam_app_v/core/widgets/primary_button.dart';
import 'package:online_exam_app_v/features/exams/presentation/screens/exams_screen.dart';

class ExploreScreen extends StatelessWidget {
  final String subjectId = "670037f6728c92b7fdf434fc";
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.blue,
        title: Text(
          "explors Screen",
          style: AppTextStyles.s20w700(AppColors.white),
        ),
      ),
      body: Center(
        child: SizedBox(
          width: double.infinity,
          child: PrimaryButton(
            onPressed: () {
              Navigator.pushNamed(
                context,
                ExamsScreen.routeName,
                arguments: subjectId,
              );
            },
            text: "go to exams",
          ),
        ),
      ),
    );
  }
}
