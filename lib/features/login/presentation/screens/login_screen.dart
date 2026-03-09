// lib/features/auth/presentation/pages/login_page.dart
import 'package:flutter/material.dart';
import 'package:online_exam_app_v/core/theme/app_colors.dart';
import 'package:online_exam_app_v/core/theme/app_sizes.dart';
import 'package:online_exam_app_v/core/theme/app_text_styles.dart';
import 'package:online_exam_app_v/core/widgets/primary_button.dart';
import 'package:online_exam_app_v/core/widgets/rich_text_with_link.dart';
import 'package:online_exam_app_v/features/forget_password/presentation/screens/forget_password_screen.dart';
import 'package:online_exam_app_v/features/home/presentation/screens/home_screen.dart';
import 'package:online_exam_app_v/features/register/presentation/screens/register_screen.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = "login";
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _rememberMe = false;
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login() {
    setState(() => _isLoading = true);
    Future.delayed(const Duration(seconds: 2), () {
      setState(() => _isLoading = false);
      Navigator.pushReplacementNamed(context, HomeScreen.routeName);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        centerTitle: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppSizes.w(24),
            vertical: AppSizes.h(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'Email',
                  hintText: 'Enter your email',
                ),
              ),

              SizedBox(height: AppSizes.h(20)),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  label: Text("data"),
                  hintStyle: AppTextStyles.s14w400(AppColors.gray),
                  hintText: 'Enter your password',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.gray),
                  ),
                ),
              ),

              SizedBox(height: AppSizes.h(16)),

              // Remember me + Forgot password
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Checkbox(
                        value: _rememberMe,
                        onChanged: (value) {
                          setState(() => _rememberMe = value ?? false);
                        },
                        activeColor: AppColors.blue,
                      ),
                      Text('Remember me', style: AppTextStyles.s14w400()),
                    ],
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        ForgetPasswordScreen.routeName,
                      );
                    },
                    child: Text(
                      'Forgot password?',
                      style: AppTextStyles.s14w500(AppColors.blue),
                    ),
                  ),
                ],
              ),

              SizedBox(height: AppSizes.h(32)),

              PrimaryButton(onPressed: _login, text: "login"),

              SizedBox(height: AppSizes.h(24)),

              RichTextWithLink(
                linkTextColor: AppColors.blue,
                normalText: "Don't have an account? ",
                linkText: "Sign up",
                onLinkTap: () {
                  Navigator.pushNamed(context, RegisterScreen.routeName);
                },
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
