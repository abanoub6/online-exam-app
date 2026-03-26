import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_exam_app_v/config/di/di.dart';
import 'package:online_exam_app_v/core/theme/app_colors.dart';
import 'package:online_exam_app_v/core/theme/app_text_styles.dart';
import 'package:online_exam_app_v/core/widgets/rich_text_with_link.dart';
import 'package:online_exam_app_v/features/forgot_password/presentation/screens/reset_password_screen.dart';
import 'package:online_exam_app_v/features/forgot_password/presentation/view_model/cubits/verify_reset_code_view_model.dart';
import 'package:online_exam_app_v/features/forgot_password/presentation/view_model/states/verify_reset_code_state.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../../core/constants/screen_names.dart';

class VerifyResetCodeScreen extends StatelessWidget {
  static const String routeName = 'verifyResetCode';
  final String email;

  const VerifyResetCodeScreen({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<VerifyResetCodeCubit>(),
      child: _VerifyResetCodeView(email: email),
    );
  }
}

class _VerifyResetCodeView extends StatefulWidget {
  final String email;

  const _VerifyResetCodeView({required this.email});

  @override
  State<_VerifyResetCodeView> createState() => _VerifyResetCodeViewState();
}

class _VerifyResetCodeViewState extends State<_VerifyResetCodeView> {
  bool _hasError = false;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<VerifyResetCodeCubit>();

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () =>
              Navigator.pushReplacementNamed(context, ScreenNames.loginScreen),
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: AppColors.black,
            weight: 20,
          ),
        ),
        title: Text("Password", style: AppTextStyles.s20w500(AppColors.black)),
      ),
      body: BlocListener<VerifyResetCodeCubit, VerifyResetCodeState>(
        listener: (context, state) {
          if (state is VerifyResetCodeSuccess) {
            setState(() => _hasError = false);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ResetPasswordScreen(email: widget.email),
              ),
            );
          } else if (state is VerifyResetCodeFailure) {
            setState(() => _hasError = true);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          } else if (state is VerifyResetCodeCodeResent) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Code resent to your email'),
                backgroundColor: Colors.green,
              ),
            );
          }
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const SizedBox(height: 24),
              Text(
                'Email verification',
                style: AppTextStyles.s18w500(AppColors.black),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Please enter your code that send to your email address',
                  style: AppTextStyles.s14w400(AppColors.black),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 32),

              // OTP fields
              PinCodeTextField(
                appContext: context,
                length: 6,
                onChanged: (value) {
                  cubit.setCode(value);
                  if (_hasError) {
                    setState(() => _hasError = false);
                  }
                },
                onCompleted: (_) => cubit.verifyCode(),
                keyboardType: TextInputType.number,
                animationType: AnimationType.scale,
                animationDuration: const Duration(milliseconds: 200),
                textStyle: AppTextStyles.s24w400(),
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(15),
                  fieldHeight: 55,
                  fieldWidth: 55,
                  activeFillColor: _hasError
                      ? AppColors.white
                      : const Color(0xFFE0E5F3),
                  inactiveFillColor: _hasError
                      ? AppColors.white
                      : const Color(0xFFE0E5F3),
                  selectedFillColor: _hasError
                      ? AppColors.white
                      : const Color(0xFFE0E5F3),
                  activeColor: _hasError ? Colors.red : const Color(0xFFE0E5F3),
                  inactiveColor: _hasError
                      ? Colors.red
                      : const Color(0xFFE0E5F3),
                  selectedColor: _hasError ? Colors.red : AppColors.blue,
                  borderWidth: 1.5,
                ),
                enableActiveFill: true,
                cursorColor: AppColors.blue,
              ),

              // Error message
              if (_hasError)
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.error_outline, color: Colors.red, size: 16),
                        const SizedBox(width: 4),
                        Text(
                          'Invalid code',
                          style: AppTextStyles.s14w400(Colors.red),
                        ),
                      ],
                    ),
                  ),
                ),

              const SizedBox(height: 24),

              // Resend code
              RichTextWithLink(
                normalText: "Didn't receive code? ",
                linkText: 'Resend',
                onLinkTap: () => cubit.resendCode(widget.email),
                linkTextColor: AppColors.blue,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
