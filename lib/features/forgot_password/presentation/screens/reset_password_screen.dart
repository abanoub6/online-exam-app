import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_exam_app_v/core/theme/app_colors.dart';
import 'package:online_exam_app_v/core/theme/app_sizes.dart';
import 'package:online_exam_app_v/core/theme/app_text_styles.dart';
import 'package:online_exam_app_v/core/utilies/validators.dart';
import 'package:online_exam_app_v/core/widgets/primary_button.dart';
import 'package:online_exam_app_v/features/forgot_password/presentation/view_model/cubits/forgot_password_view_model.dart';
import 'package:online_exam_app_v/features/forgot_password/presentation/view_model/states/forgot_password_events.dart';
import 'package:online_exam_app_v/features/forgot_password/presentation/view_model/states/forgot_password_state.dart';
import 'package:online_exam_app_v/features/login/presentation/screens/login_screen.dart';

class ResetPasswordScreen extends StatelessWidget {
  static const String routeName = 'resetPassword';
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const _ResetPasswordView();
  }
}

class _ResetPasswordView extends StatelessWidget {
  const _ResetPasswordView();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ForgotPasswordViewModel>();

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () =>
              Navigator.pushReplacementNamed(context, LoginScreen.routeName),
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: AppColors.black,
          ),
        ),
        title: Text("Password", style: AppTextStyles.s20w500(AppColors.black)),
      ),
      body: BlocListener<ForgotPasswordViewModel, ForgotPasswordState>(
        listener: (context, state) {
          if (state is ForgotPasswordResetSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Password reset successfully!'),
                backgroundColor: AppColors.green,
              ),
            );
            Navigator.pushReplacementNamed(context, LoginScreen.routeName);
          } else if (state is ForgotPasswordResetFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: AppColors.red,
              ),
            );
          }
        },
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: AppSizes.h(24)),
          child: Form(
            key: cubit.resetFormKey,
            child: Column(
              children: [
                SizedBox(height: AppSizes.h(24)),
                Text(
                  'Reset password',
                  style: AppTextStyles.s18w500(AppColors.black),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: AppSizes.h(8)),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: AppSizes.h(10)),
                  child: Text(
                    'Password must not be empty and must contain 6 characters with upper case letter and one number at least',
                    style: AppTextStyles.s14w400(AppColors.black),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: AppSizes.h(32)),
                TextFormField(
                  controller: cubit.passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Enter your password',
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
                SizedBox(height: AppSizes.h(24)),
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
                SizedBox(height: AppSizes.h(40)),
                BlocBuilder<ForgotPasswordViewModel, ForgotPasswordState>(
                  builder: (context, state) {
                    final isLoading = state is ForgotPasswordResetLoading;
                    return SizedBox(
                      width: double.infinity,
                      height: AppSizes.h(55),
                      child: PrimaryButton(
                        isLoading: isLoading,
                        text: 'Continue',
                        onPressed: isLoading
                            ? null
                            : () {
                                if (cubit.resetFormKey.currentState!
                                    .validate()) {
                                  cubit.doEvent(ResetPasswordEvent());
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
