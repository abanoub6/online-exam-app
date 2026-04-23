import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_exam_app_v/core/constants/app_strings.dart';
import 'package:online_exam_app_v/core/theme/app_colors.dart';
import 'package:online_exam_app_v/core/theme/app_text_styles.dart';
import 'package:online_exam_app_v/features/profile/domain/entities/profile_entity.dart';
import 'package:online_exam_app_v/features/profile/presentation/screens/change_password_screen.dart';
import 'package:online_exam_app_v/features/profile/presentation/view_model/cubit/profile_view_model.dart';

class EditProfilePasswordField extends StatelessWidget {
  final ProfileEntity? profile;

  const EditProfilePasswordField({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ProfileViewModel>();

    return TextFormField(
      initialValue: '••••••',
      readOnly: true,
      obscureText: true,
      decoration: InputDecoration(
        label: Text(
          AppStrings.password,
          style: AppTextStyles.s14w400(AppColors.black),
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        floatingLabelStyle: AppTextStyles.s14w400(AppColors.black),
        filled: false,
        suffixIcon: TextButton(
          onPressed: profile == null
              ? null
              : () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => BlocProvider.value(
                      value: cubit,
                      child: const ChangePasswordScreen(),
                    ),
                  ),
                ),
          child: Text(
            AppStrings.change,
            style: AppTextStyles.s12w500(AppColors.blue),
          ),
        ),
      ),
    );
  }
}
