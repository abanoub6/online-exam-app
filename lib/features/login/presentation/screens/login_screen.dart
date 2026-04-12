import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_exam_app_v/config/di/di.dart';
import 'package:online_exam_app_v/core/constants/app_strings.dart';
import 'package:online_exam_app_v/core/theme/app_colors.dart';
import 'package:online_exam_app_v/core/theme/app_sizes.dart';
import 'package:online_exam_app_v/core/theme/app_text_styles.dart';
import 'package:online_exam_app_v/core/utilies/app_validators.dart';
import 'package:online_exam_app_v/core/widgets/primary_button.dart';
import 'package:online_exam_app_v/core/widgets/rich_text_with_link.dart';
import 'package:online_exam_app_v/features/forgot_password/presentation/screens/forgot_password_screen.dart';
import 'package:online_exam_app_v/features/home/presentation/screens/home_screen.dart';
import 'package:online_exam_app_v/features/login/data/models/login_request.dart';
import 'package:online_exam_app_v/features/login/presentation/view_model/states/login_events.dart';
import 'package:online_exam_app_v/features/register/presentation/screens/register_screen.dart';
import 'package:online_exam_app_v/features/login/presentation/view_model/cubit/login_view_model.dart';
import 'package:online_exam_app_v/features/login/presentation/view_model/states/login_state.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = 'loginScreen';
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formState = GlobalKey<FormState>();
  bool rememberMe = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

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
              child: SingleChildScrollView(
                child: Column(
                  spacing: AppSizes.h(24),
                  children: [
                    TextFormField(
                      controller: emailController,
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
                    ),
                    TextFormField(
                      controller: passwordController,
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
                      validator: (value) => AppValidators.required(
                        value,
                        message: AppStrings.pleaseEnterYourPassword,
                      ),
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
                        const Spacer(),
                        GestureDetector(
                          onTap: () => Navigator.pushNamed(
                            context,
                            ForgotPasswordScreen.routeName,
                          ),
                          child: Text(
                            AppStrings.forgetPasswordLink,
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
                              if (state.loginState.isLoading) return;

                              if (state.loginState.data != null) {
                                Navigator.pushReplacementNamed(
                                  context,
                                  HomeScreen.routeName,
                                );
                              } else if (state.loginState.errorMessage !=
                                  null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      state.loginState.errorMessage!,
                                    ),
                                    backgroundColor: AppColors.red,
                                  ),
                                );
                              }
                            },
                            builder: (context, state) {
                              return PrimaryButton(
                                onPressed: state.loginState.isLoading
                                    ? null
                                    : () {
                                        if (_formState.currentState!
                                            .validate()) {
                                          context
                                              .read<LoginViewModel>()
                                              .doEvent(
                                                LoginUserEvent(
                                                  login: LoginRequest(
                                                    email: emailController.text
                                                        .trim(),
                                                    password:
                                                        passwordController.text,
                                                    rememberMe: rememberMe,
                                                  ),
                                                ),
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
                      onLinkTap: () => Navigator.pushNamed(
                        context,
                        RegisterScreen.routeName,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
