import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_exam_app_v/config/di/di.dart';
import 'package:online_exam_app_v/core/constants/app_strings.dart';
import 'package:online_exam_app_v/core/theme/app_colors.dart';
import 'package:online_exam_app_v/core/theme/app_sizes.dart';
import 'package:online_exam_app_v/core/theme/app_text_styles.dart';
import 'package:online_exam_app_v/core/utilies/app_validators.dart';
import 'package:online_exam_app_v/core/widgets/primary_button.dart';
import 'package:online_exam_app_v/features/forgot_password/presentation/screens/verify_reset_code_screen.dart';
import 'package:online_exam_app_v/features/forgot_password/presentation/view_model/cubits/forgot_password_view_model.dart';
import 'package:online_exam_app_v/features/forgot_password/presentation/view_model/states/forgot_password_events.dart';
import 'package:online_exam_app_v/features/forgot_password/presentation/view_model/states/forgot_password_state.dart';
import 'package:online_exam_app_v/features/login/presentation/screens/login_screen.dart';

class ForgotPasswordScreen extends StatelessWidget {
  static const String routeName = AppStrings.forgetPassword;
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<ForgotPasswordViewModel>(),
      child: const _ForgotPasswordBody(),
    );
  }
}

class _ForgotPasswordBody extends StatefulWidget {
  const _ForgotPasswordBody();

  @override
  State<_ForgotPasswordBody> createState() => _ForgotPasswordBodyState();
}

class _ForgotPasswordBodyState extends State<_ForgotPasswordBody> {
  final ValueNotifier<bool> _isEmailValid = ValueNotifier(true);
  final emailController = TextEditingController();
  final emailFormKey = GlobalKey<FormState>();
  late ForgotPasswordViewModel cubit;

  @override
  void initState() {
    super.initState();
    cubit = context.read<ForgotPasswordViewModel>();
  }

  @override
  void dispose() {
    emailController.dispose();
    _isEmailValid.dispose();
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
          if (state is ForgotPasswordEmailSuccess) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => BlocProvider.value(
                  value: cubit,
                  child: const VerifyResetCodeScreen(),
                ),
              ),
            );
          } else if (state is ForgotPasswordEmailFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage ?? ''),
                backgroundColor: AppColors.red,
              ),
            );
          }
        },
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: AppSizes.h(24)),
          child: Column(
            children: [
              SizedBox(height: AppSizes.h(24)),
              Text(
                AppStrings.forgetPasswordTitle,
                style: AppTextStyles.s18w500(AppColors.black),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: AppSizes.h(8)),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: AppSizes.h(44)),
                child: Text(
                  AppStrings.emailDescription,
                  style: AppTextStyles.s14w400(AppColors.black),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: AppSizes.h(32)),
              Form(
                key: emailFormKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: emailController,
                      decoration: InputDecoration(
                        hintText: AppStrings.enterYourEmail,
                        label: Text(
                          AppStrings.email,
                          style: AppTextStyles.s14w400(AppColors.black),
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        floatingLabelStyle: AppTextStyles.s14w400(
                          AppColors.black,
                        ),
                        filled: false,
                      ),
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.done,
                      validator: (value) => AppValidators.compose([
                        (v) => AppValidators.required(
                          v,
                          message: AppStrings.pleaseEnterYourEmail,
                        ),
                        (v) => AppValidators.email(
                          v,
                          message: AppStrings.thisEmailIsNotValid,
                        ),
                      ], value),
                      onChanged: (_) {
                        if (!_isEmailValid.value) _isEmailValid.value = true;
                      },
                    ),
                    SizedBox(height: AppSizes.h(50)),
                    ValueListenableBuilder<bool>(
                      valueListenable: _isEmailValid,
                      builder: (context, isEmailValid, _) {
                        return BlocBuilder<
                          ForgotPasswordViewModel,
                          ForgotPasswordState
                        >(
                          builder: (context, state) {
                            final isLoading =
                                state is ForgotPasswordEmailLoading;
                            return SizedBox(
                              width: double.infinity,
                              height: AppSizes.h(56),
                              child: PrimaryButton(
                                isLoading: isLoading,
                                text: AppStrings.continueText,
                                onPressed: isEmailValid && !isLoading
                                    ? () {
                                        if (emailFormKey.currentState!
                                            .validate()) {
                                          cubit.doEvent(
                                            SendEmailEvent(
                                              emailController.text.trim(),
                                            ),
                                          );
                                        } else {
                                          _isEmailValid.value = false;
                                        }
                                      }
                                    : null,
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
