import 'package:flutter/material.dart';
import 'package:online_exam_app_v/core/theme/app_colors.dart';
import 'package:online_exam_app_v/core/theme/app_text_styles.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = "homeScreen";
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.blue,
        title: Text("home screen", style: AppTextStyles.s16w400()),
      ),
    );
  }
}
