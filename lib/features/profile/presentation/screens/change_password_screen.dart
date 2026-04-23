import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_exam_app_v/core/constants/app_strings.dart';
import 'package:online_exam_app_v/core/theme/app_colors.dart';
import 'package:online_exam_app_v/core/theme/app_sizes.dart';
import 'package:online_exam_app_v/core/theme/app_text_styles.dart';
import 'package:online_exam_app_v/core/utilies/app_validators.dart';
import 'package:online_exam_app_v/core/widgets/primary_button.dart';
import 'package:online_exam_app_v/features/profile/data/models/change_password_request.dart';
import 'package:online_exam_app_v/features/profile/presentation/view_model/cubit/profile_view_model.dart';
import 'package:online_exam_app_v/features/profile/presentation/view_model/states/profile_events.dart';
import 'package:online_exam_app_v/features/profile/presentation/view_model/states/profile_state.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final oldPasswordController = TextEditingController();
  final passwordController = TextEditingController();
  final rePasswordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  late ProfileViewModel cubit;

  @override
  void initState() {
    super.initState();
    cubit = context.read<ProfileViewModel>();
  }

  @override
  void dispose() {
    oldPasswordController.dispose();
    passwordController.dispose();
    rePasswordController.dispose();
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
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: AppColors.black,
          ),
        ),
        title: Text(
          AppStrings.resetPasswordTitle,
          style: AppTextStyles.s20w500(AppColors.black),
        ),
      ),
      body: BlocListener<ProfileViewModel, ProfileState>(
        listener: (context, state) {
          if (state is ChangePasswordSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(AppStrings.passwordChangedSuccessfully),
                backgroundColor: AppColors.green,
              ),
            );
            Navigator.pop(context);
          } else if (state is ChangePasswordFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage),
                backgroundColor: AppColors.red,
              ),
            );
          }
        },
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: AppSizes.h(24)),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                SizedBox(height: AppSizes.h(32)),

                TextFormField(
                  controller: oldPasswordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    label: Text(
                      AppStrings.currentPassword,
                      style: AppTextStyles.s14w400(AppColors.black),
                    ),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    floatingLabelStyle: AppTextStyles.s14w400(AppColors.black),
                    filled: false,
                  ),
                  textInputAction: TextInputAction.next,
                  validator: (value) => AppValidators.required(
                    value,
                    message: AppStrings.pleaseEnterYourCurrentPassword,
                  ),
                ),
                SizedBox(height: AppSizes.h(24)),

                TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
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
                  controller: rePasswordController,
                  obscureText: true,
                  decoration: InputDecoration(
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

                BlocBuilder<ProfileViewModel, ProfileState>(
                  builder: (context, state) {
                    final isLoading = state is ChangePasswordLoading;
                    return SizedBox(
                      width: double.infinity,
                      height: AppSizes.h(56),
                      child: PrimaryButton(
                        isLoading: isLoading,
                        text: AppStrings.update,
                        onPressed: isLoading
                            ? null
                            : () {
                                if (formKey.currentState!.validate()) {
                                  cubit.doEvent(
                                    ChangePasswordEvent(
                                      ChangePasswordRequest(
                                        oldPassword: oldPasswordController.text,
                                        password: passwordController.text,
                                        rePassword: rePasswordController.text,
                                      ),
                                    ),
                                  );
                                }
                              },
                      ),
                    );
                  },
                ),
                SizedBox(height: AppSizes.h(24)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
