import 'package:flutter/material.dart';
import 'package:online_exam_app_v/core/theme/app_colors.dart';
import 'package:online_exam_app_v/core/theme/app_text_styles.dart';

class ProfileReadOnlyField extends StatelessWidget {
  final String label;
  final String value;

  const ProfileReadOnlyField({
    super.key,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: value,
      readOnly: true,
      decoration: InputDecoration(
        label: Text(label, style: AppTextStyles.s14w400(AppColors.black)),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        floatingLabelStyle: AppTextStyles.s14w400(AppColors.black),
        filled: false,
      ),
    );
  }
}
