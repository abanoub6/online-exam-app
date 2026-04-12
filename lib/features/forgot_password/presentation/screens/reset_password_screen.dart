import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_exam_app_v/core/constants/app_strings.dart';
import 'package:online_exam_app_v/core/theme/app_colors.dart';
import 'package:online_exam_app_v/core/theme/app_sizes.dart';
import 'package:online_exam_app_v/core/theme/app_text_styles.dart';
import 'package:online_exam_app_v/core/utilies/app_validators.dart';
import 'package:online_exam_app_v/core/widgets/primary_button.dart';
import 'package:online_exam_app_v/features/forgot_password/presentation/view_model/cubits/forgot_password_view_model.dart';
import 'package:online_exam_app_v/features/forgot_password/presentation/view_model/states/forgot_password_events.dart';
import 'package:online_exam_app_v/features/forgot_password/presentation/view_model/states/forgot_password_state.dart';
import 'package:online_exam_app_v/features/login/presentation/screens/login_screen.dart';

class ResetPasswordScreen extends StatelessWidget {
  static const String routeName = AppStrings.resetPassword;
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const _ResetPasswordView();
  }
}

class _ResetPasswordView extends StatefulWidget {
  const _ResetPasswordView();

  @override
  State<_ResetPasswordView> createState() => _ResetPasswordViewState();
}

class _ResetPasswordViewState extends State<_ResetPasswordView> {
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final resetFormKey = GlobalKey<FormState>();
  late ForgotPasswordViewModel cubit;

  @override
  void initState() {
    super.initState();
    cubit = context.read<ForgotPasswordViewModel>();
  }

  @override
  void dispose() {
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
        title: Text(
          AppStrings.password,
          style: AppTextStyles.s20w500(AppColors.black),
        ),
      ),
      body: BlocListener<ForgotPasswordViewModel, ForgotPasswordState>(
        listener: (context, state) {
          if (state is ForgotPasswordResetSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(AppStrings.passwordResetSuccessfully),
                backgroundColor: AppColors.green,
              ),
            );
            Navigator.pushReplacementNamed(context, LoginScreen.routeName);
          } else if (state is ForgotPasswordResetFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage ?? ''),
                backgroundColor: AppColors.red,
              ),
            );
          }
        },
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: AppSizes.h(24)),
          child: Form(
            key: resetFormKey,
            child: Column(
              children: [
                SizedBox(height: AppSizes.h(24)),
                Text(
                  AppStrings.resetPasswordTitle,
                  style: AppTextStyles.s18w500(AppColors.black),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: AppSizes.h(8)),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: AppSizes.h(10)),
                  child: Text(
                    AppStrings.passwordRequirements,
                    style: AppTextStyles.s14w400(AppColors.black),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: AppSizes.h(32)),
                TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: AppStrings.enterYourPassword,
                    label: Text(
                      AppStrings.newPassword,
                      style: AppTextStyles.s14w400(AppColors.black),
                    ),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    floatingLabelStyle: AppTextStyles.s14w400(AppColors.black),
                    filled: false,
                  ),
                  textInputAction: TextInputAction.next,
                  validator: AppValidators.strongPassword,
                ),
                SizedBox(height: AppSizes.h(24)),
                TextFormField(
                  controller: confirmPasswordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: AppStrings.confirmPassword,
                    label: Text(
                      AppStrings.confirmPassword,
                      style: AppTextStyles.s14w400(AppColors.black),
                    ),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    floatingLabelStyle: AppTextStyles.s14w400(AppColors.black),
                    filled: false,
                  ),
                  textInputAction: TextInputAction.done,
                  validator: (value) => AppValidators.confirmPassword(
                    value,
                    passwordController.text,
                  ),
                ),
                SizedBox(height: AppSizes.h(40)),
                BlocBuilder<ForgotPasswordViewModel, ForgotPasswordState>(
                  builder: (context, state) {
                    final isLoading = state is ForgotPasswordResetLoading;
                    return SizedBox(
                      width: double.infinity,
                      height: AppSizes.h(56),
                      child: PrimaryButton(
                        isLoading: isLoading,
                        text: AppStrings.continueText,
                        onPressed: isLoading
                            ? null
                            : () {
                                if (resetFormKey.currentState!.validate()) {
                                  cubit.doEvent(
                                    ResetPasswordEvent(passwordController.text),
                                  );
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
