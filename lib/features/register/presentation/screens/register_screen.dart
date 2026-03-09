import 'package:flutter/material.dart';
import 'package:online_exam_app_v/core/theme/app_colors.dart';
import 'package:online_exam_app_v/core/theme/app_text_styles.dart';

class RegisterScreen extends StatelessWidget {
  static const String routeName = "register";
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.blue,
        title: Text("register", style: AppTextStyles.s16w400()),
      ),
    );
  }
}
