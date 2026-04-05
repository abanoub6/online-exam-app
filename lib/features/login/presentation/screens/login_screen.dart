import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_exam_app_v/config/di/di.dart';
import 'package:online_exam_app_v/core/constants/app_strings.dart';
import 'package:online_exam_app_v/core/theme/app_colors.dart';
import 'package:online_exam_app_v/core/theme/app_sizes.dart';
import 'package:online_exam_app_v/core/theme/app_text_styles.dart';
import 'package:online_exam_app_v/core/widgets/primary_button.dart';
import 'package:online_exam_app_v/core/widgets/rich_text_with_link.dart';
import 'package:online_exam_app_v/features/forget_password/presentation/screens/forget_password_screen.dart';
import 'package:online_exam_app_v/features/login/data/models/login_request.dart';
import 'package:online_exam_app_v/features/login/presentation/cubit/login_view_model/login_view_model.dart';
import 'package:online_exam_app_v/features/login/presentation/cubit/states/login_events.dart';
import 'package:online_exam_app_v/features/login/presentation/cubit/states/login_state.dart';
import 'package:online_exam_app_v/features/register/presentation/screens/register_screen.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = 'loginScreen';
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // LoginViewModel viewModel = getIt.get<LoginViewModel>();
  final TextEditingController emailContorller = TextEditingController();
  final TextEditingController passwordContorller = TextEditingController();
  final GlobalKey<FormState> _formState = GlobalKey<FormState>();

  @override
  void dispose() {
    emailContorller.dispose();
    passwordContorller.dispose();
    super.dispose();
  }

  bool rememberMe = false;
  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginViewModel>(
      create: (context) => getIt<LoginViewModel>(),
      child: Builder(
        builder: (context) => Scaffold(
          appBar: AppBar(
            title: Text(AppStrings.login, style: AppTextStyles.s20w500()),
          ),
          body: Padding(
            padding: EdgeInsets.all(AppSizes.h(16)),
            child: Form(
              key: _formState,
              child: Column(
                spacing: AppSizes.h(24),
                children: [
                  TextField(
                    controller: emailContorller,
                    decoration: InputDecoration(
                      label: Text(
                        AppStrings.email,
                        style: AppTextStyles.s14w400(AppColors.black),
                      ),
                      hintText: AppStrings.enterYourEmail,
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      floatingLabelStyle: AppTextStyles.s14w400(
                        AppColors.black,
                      ),
                      filled: false,
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  TextField(
                    controller: passwordContorller,
                    obscureText: true,
                    decoration: InputDecoration(
                      label: Text(
                        AppStrings.password,
                        style: AppTextStyles.s14w400(AppColors.black),
                      ),
                      hintText: AppStrings.enterYourPassword,
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      floatingLabelStyle: AppTextStyles.s14w400(
                        AppColors.black,
                      ),
                      filled: false,
                    ),
                    keyboardType: TextInputType.visiblePassword,
                  ),
                  Row(
                    children: [
                      Checkbox(
                        value: rememberMe,
                        tristate: true,
                        onChanged: (value) => setState(() {
                          rememberMe = value ?? false;
                        }),
                      ),
                      Text(
                        AppStrings.rememberMe,
                        style: AppTextStyles.s14w400(),
                      ),
                      Spacer(),

                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            ForgetPasswordScreen.routeName,
                          );
                        },
                        child: Text(
                          AppStrings.forgetPassword,
                          style: AppTextStyles.s12w400().copyWith(
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: BlocConsumer<LoginViewModel, LoginStates>(
                          listener: (context, state) {
                            log(state.loginState.toString());
                            if (state.loginState.data != null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(AppStrings.work)),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    state.loginState.errorMessage ??
                                        AppStrings.noErrorMessages,
                                  ),
                                ),
                              );
                            }
                          },
                          builder: (context, state) {
                            return PrimaryButton(
                              onPressed: () {
                                if (_formState.currentState!.validate()) {
                                  LoginRequest params = LoginRequest(
                                    email: emailContorller.text.trim(),
                                    password: passwordContorller.text,
                                    rememberMe: rememberMe,
                                  );
                                  context.read<LoginViewModel>().doEvent(
                                    LoginUserEvent(login: params),
                                  );
                                }
                              },
                              text: AppStrings.login,
                              isLoading: state.loginState.isLoading,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  RichTextWithLink(
                    normalText: AppStrings.dontHaveAnAccount,
                    linkText: AppStrings.signUp,
                    linkTextColor: AppColors.blue,
                    onLinkTap: () =>
                        Navigator.pushNamed(context, RegisterScreen.routeName),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
