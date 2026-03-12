import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_exam_app_v/config/di/di.dart';
import 'package:online_exam_app_v/core/theme/app_colors.dart';
import 'package:online_exam_app_v/core/theme/app_text_styles.dart';
import 'package:online_exam_app_v/core/utilies/validators.dart';
import 'package:online_exam_app_v/core/widgets/primary_button.dart';
import 'package:online_exam_app_v/features/forgot_password/presentation/screens/verify_reset_code_screen.dart';
import 'package:online_exam_app_v/features/forgot_password/presentation/view_model/cubits/forgot_password_view_model.dart';
import 'package:online_exam_app_v/features/forgot_password/presentation/view_model/states/forgot_password_state.dart';

class ForgotPasswordScreen extends StatelessWidget {
  static const String routeName = "forgetPassword";
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<ForgotPasswordCubit>(),
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
  bool _isEmailValid = true;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ForgotPasswordCubit>();

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
            weight: 20,
          ),
        ),
        title: Text("Password", style: AppTextStyles.s20w500(AppColors.black)),
      ),
      body: BlocListener<ForgotPasswordCubit, ForgotPasswordState>(
        listener: (context, state) {
          if (state is ForgotPasswordSuccess) {
            Navigator.pushNamed(
              context,
              VerifyResetCodeScreen.routeName,
              arguments: cubit.emailController.text.trim(),
            );
          } else if (state is ForgotPasswordFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const SizedBox(height: 24),
              Text(
                'Forget password',
                style: AppTextStyles.s18w500(AppColors.black),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 45),
                child: Text(
                  'Please enter your email associated to your account',
                  style: AppTextStyles.s14w400(AppColors.black),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 32),
              Form(
                key: cubit.formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: cubit.emailController,
                      decoration: InputDecoration(
                        hintText: 'Enter your email',
                        label: Text(
                          'Email',
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
                      validator: Validators.email,
                      onChanged: (_) {
                        if (!_isEmailValid) {
                          setState(() {
                            _isEmailValid = true;
                          });
                        }
                      },
                    ),
                    const SizedBox(height: 50),
                    BlocBuilder<ForgotPasswordCubit, ForgotPasswordState>(
                      builder: (context, state) {
                        return SizedBox(
                          width: double.infinity,
                          height: 55,
                          child: PrimaryButton(
                            isLoading: state is ForgotPasswordLoading,
                            text: 'Continue',
                            onPressed: state is ForgotPasswordLoading
                                ? null
                                : () {
                                    if (cubit.formKey.currentState!
                                        .validate()) {
                                      cubit.forgotPassword();
                                    } else {
                                      setState(() {
                                        _isEmailValid = false;
                                      });
                                    }
                                  },
                          ),

                          // ElevatedButton(
                          //   style: ElevatedButton.styleFrom(
                          //     backgroundColor: !_isEmailValid
                          //         ? AppColors.gray
                          //         : AppColors.blue,
                          //     shape: RoundedRectangleBorder(
                          //       borderRadius: BorderRadius.circular(30),
                          //     ),
                          //   ),
                          //   onPressed: state is ForgotPasswordLoading
                          //       ? null
                          //       : () {
                          //           if (cubit.formKey.currentState!
                          //               .validate()) {
                          //             cubit.forgotPassword();
                          //           } else {
                          //             setState(() {
                          //               _isEmailValid = false;
                          //             });
                          //           }
                          //         },
                          //   child: state is ForgotPasswordLoading
                          //       ? const CircularProgressIndicator(
                          //           color: AppColors.white,
                          //         )
                          //       : Text(
                          //           "Continue",
                          //           style: AppTextStyles.s16w500(
                          //             AppColors.white,
                          //           ),
                          //         ),
                          // ),
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
