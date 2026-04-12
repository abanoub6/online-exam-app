import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_exam_app_v/core/constants/app_strings.dart';
import 'package:online_exam_app_v/core/theme/app_colors.dart';
import 'package:online_exam_app_v/core/theme/app_sizes.dart';
import 'package:online_exam_app_v/core/theme/app_text_styles.dart';
import 'package:online_exam_app_v/core/widgets/rich_text_with_link.dart';
import 'package:online_exam_app_v/features/forgot_password/presentation/screens/reset_password_screen.dart';
import 'package:online_exam_app_v/features/forgot_password/presentation/view_model/cubits/forgot_password_view_model.dart';
import 'package:online_exam_app_v/features/forgot_password/presentation/view_model/states/forgot_password_events.dart';
import 'package:online_exam_app_v/features/forgot_password/presentation/view_model/states/forgot_password_state.dart';
import 'package:online_exam_app_v/features/login/presentation/screens/login_screen.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class VerifyResetCodeScreen extends StatelessWidget {
  static const String routeName = AppStrings.verifyResetCode;
  const VerifyResetCodeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const _VerifyResetCodeView();
  }
}

class _VerifyResetCodeView extends StatefulWidget {
  const _VerifyResetCodeView();

  @override
  State<_VerifyResetCodeView> createState() => _VerifyResetCodeViewState();
}

class _VerifyResetCodeViewState extends State<_VerifyResetCodeView> {
  final ValueNotifier<bool> _hasError = ValueNotifier(false);
  late ForgotPasswordViewModel cubit;

  @override
  void initState() {
    super.initState();
    cubit = context.read<ForgotPasswordViewModel>();
  }

  @override
  void dispose() {
    _hasError.dispose();
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
          if (state is ForgotPasswordVerifySuccess) {
            _hasError.value = false;
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => BlocProvider.value(
                  value: cubit,
                  child: const ResetPasswordScreen(),
                ),
              ),
            );
          } else if (state is ForgotPasswordVerifyFailure) {
            _hasError.value = true;
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage ?? ''),
                backgroundColor: AppColors.red,
              ),
            );
          } else if (state is ForgotPasswordCodeResent) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(AppStrings.codeResentToYourEmail),
                backgroundColor: AppColors.green,
              ),
            );
          }
        },
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: AppSizes.h(24)),
          child: Column(
            children: [
              SizedBox(height: AppSizes.h(24)),
              Text(
                AppStrings.emailVerification,
                style: AppTextStyles.s18w500(AppColors.black),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: AppSizes.h(8)),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: AppSizes.h(20)),
                child: Text(
                  AppStrings.enterYourCode,
                  style: AppTextStyles.s14w400(AppColors.black),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: AppSizes.h(32)),
              ValueListenableBuilder<bool>(
                valueListenable: _hasError,
                builder: (context, hasError, _) {
                  return Column(
                    children: [
                      PinCodeTextField(
                        appContext: context,
                        length: 6,
                        onChanged: (value) {
                          cubit.setCode(value);
                          if (hasError) _hasError.value = false;
                        },
                        onCompleted: (_) => cubit.doEvent(VerifyCodeEvent()),
                        keyboardType: TextInputType.number,
                        animationType: AnimationType.scale,
                        animationDuration: const Duration(milliseconds: 200),
                        textStyle: AppTextStyles.s24w400(),
                        pinTheme: PinTheme(
                          shape: PinCodeFieldShape.box,
                          borderRadius: BorderRadius.circular(AppSizes.r(10)),
                          fieldHeight: AppSizes.h(50),
                          fieldWidth: AppSizes.w(50),
                          activeFillColor: hasError
                              ? AppColors.white
                              : AppColors.ligtGrey,
                          inactiveFillColor: hasError
                              ? AppColors.white
                              : AppColors.ligtGrey,
                          selectedFillColor: hasError
                              ? AppColors.white
                              : AppColors.ligtGrey,
                          activeColor: hasError
                              ? AppColors.red
                              : AppColors.ligtGrey,
                          inactiveColor: hasError
                              ? AppColors.red
                              : AppColors.ligtGrey,
                          selectedColor: hasError
                              ? AppColors.red
                              : AppColors.blue,
                          borderWidth: 1.5,
                        ),
                        enableActiveFill: true,
                        cursorColor: AppColors.blue,
                      ),
                      if (hasError)
                        Align(
                          alignment: Alignment.centerRight,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.error_outline,
                                color: AppColors.red,
                                size: 16,
                              ),
                              SizedBox(width: AppSizes.w(4)),
                              Text(
                                AppStrings.invalidCode,
                                style: AppTextStyles.s14w400(AppColors.red),
                              ),
                            ],
                          ),
                        ),
                    ],
                  );
                },
              ),
              SizedBox(height: AppSizes.h(24)),
              RichTextWithLink(
                normalText: AppStrings.didntReceiveCode,
                linkText: AppStrings.resend,
                onLinkTap: () => cubit.doEvent(ResendCodeEvent()),
                linkTextColor: AppColors.blue,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
