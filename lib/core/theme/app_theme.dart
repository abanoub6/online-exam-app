import 'package:flutter/material.dart';
import 'package:online_exam_app_v/core/theme/app_colors.dart';
import 'package:online_exam_app_v/core/theme/app_text_styles.dart';

class AppTheme {
  static ThemeData lightTheme() => ThemeData(
    inputDecorationTheme: InputDecorationTheme(
      focusColor: AppColors.black,
      hintStyle: AppTextStyles.s14w400(AppColors.gray),

      border: OutlineInputBorder(borderSide: BorderSide(color: AppColors.gray)),
      labelStyle: AppTextStyles.s14w400(AppColors.gray),
    ),
  );
}
