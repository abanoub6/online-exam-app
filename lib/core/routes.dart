import 'package:flutter/material.dart';
import 'package:online_exam_app_v/core/constants/screen_names.dart';
import 'package:online_exam_app_v/features/login/persentation/pages/login_page.dart';
import 'package:online_exam_app_v/features/home/presentation/screens/home_screen.dart';
import 'package:online_exam_app_v/features/register/presentation/screens/register_screen.dart';

import '../features/forgot_password/presentation/screens/forget_password_screen.dart';

Route<dynamic>? onGenerateRoute(RouteSettings settings) {
  return switch (settings.name) {
    ScreenNames.loginScreen => MaterialPageRoute(
      builder: (context) => LoginPage(),
    ),
    ScreenNames.homeScreen => MaterialPageRoute(
      builder: (context) => HomeScreen(),
    ),
    ScreenNames.forgetPassword => MaterialPageRoute(
      builder: (context) => ForgotPasswordScreen(),
    ),
    ScreenNames.signup => MaterialPageRoute(
      builder: (context) => RegisterScreen(),
    ),
    _ => MaterialPageRoute(
      builder: (context) => Scaffold(
        appBar: AppBar(),
        body: Center(child: Text("404 Not found page")),
      ),
    ),
  };
}
