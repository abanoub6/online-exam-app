import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_exam_app_v/config/di/di.dart';
import 'package:online_exam_app_v/core/theme/app_colors.dart';
import 'package:online_exam_app_v/core/theme/app_text_styles.dart';
import 'package:online_exam_app_v/core/utilies/validators.dart';
import 'package:online_exam_app_v/core/widgets/primary_button.dart';
import 'package:online_exam_app_v/features/forgot_password/presentation/view_model/cubits/reset_password_view_model.dart';
import 'package:online_exam_app_v/features/forgot_password/presentation/view_model/states/reset_password_state.dart';
import 'package:online_exam_app_v/features/login/presentation/screens/login_screen.dart';

class ResetPasswordScreen extends StatelessWidget {
  static const String routeName = 'resetPassword';
  final String email;

  const ResetPasswordScreen({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<ResetPasswordCubit>(),
      child: _ResetPasswordView(email: email),
    );
  }
}

class _ResetPasswordView extends StatelessWidget {
  final String email;

  const _ResetPasswordView({required this.email});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ResetPasswordCubit>();

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pushReplacementNamed(context, LoginScreen.routeName),
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: AppColors.black,
            weight: 20,
          ),
        ),
        title: Text("Password", style: AppTextStyles.s20w500(AppColors.black)),
      ),
      body: BlocListener<ResetPasswordCubit, ResetPasswordState>(
        listener: (context, state) {
          if (state is ResetPasswordSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Password reset successfully!'),
                backgroundColor: Colors.green,
              ),
            );
            Navigator.pushReplacementNamed(context, LoginScreen.routeName);
          } else if (state is ResetPasswordFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Form(
            key: cubit.formKey,
            child: Column(
              children: [
                const SizedBox(height: 24),
                Text(
                  'Reset password',
                  style: AppTextStyles.s18w500(AppColors.black),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    'Password must not be empty and must contain 6 characters with upper case letter and one number at least',
                    style: AppTextStyles.s14w400(AppColors.black),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 32),

                // New password field
                TextFormField(
                  controller: cubit.passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Enter you password',
                    label: Text(
                      'New password',
                      style: AppTextStyles.s14w400(AppColors.black),
                    ),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    floatingLabelStyle: AppTextStyles.s14w400(AppColors.black),
                    filled: false,
                  ),
                  textInputAction: TextInputAction.next,
                  validator: Validators.strongPassword,
                ),
                const SizedBox(height: 24),

                // Confirm password field
                TextFormField(
                  controller: cubit.confirmPasswordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Confirm password',
                    label: Text(
                      'Confirm password',
                      style: AppTextStyles.s14w400(AppColors.black),
                    ),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    floatingLabelStyle: AppTextStyles.s14w400(AppColors.black),
                    filled: false,
                  ),
                  textInputAction: TextInputAction.done,
                  validator: (value) => Validators.confirmPassword(
                    value,
                    cubit.passwordController.text,
                  ),
                ),
                const SizedBox(height: 40),

                // Continue button
                BlocBuilder<ResetPasswordCubit, ResetPasswordState>(
                  builder: (context, state) {
                    return SizedBox(
                      width: double.infinity,
                      height: 55,
                      child: PrimaryButton(
                        isLoading: state is ResetPasswordLoading,
                        text: 'Continue',
                        onPressed: state is ResetPasswordLoading
                            ? null
                            : () {
                                if (cubit.formKey.currentState!.validate()) {
                                  cubit.resetPassword(email: email);
                                }
                              },
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
