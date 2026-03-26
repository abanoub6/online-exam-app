import 'package:flutter/material.dart';
import 'package:online_exam_app_v/core/constants/screen_names.dart';
import 'package:online_exam_app_v/feature/login/persentation/pages/login_page.dart';
import 'package:online_exam_app_v/features/home/presentation/screens/home_screen.dart';

Route<dynamic>? onGenerateRoute(RouteSettings settings) {
  return switch (settings.name) {
    ScreenNames.loginScreen => MaterialPageRoute(
      builder: (context) => LoginPage(),
    ),
    ScreenNames.homeScreen => MaterialPageRoute(
      builder: (context) => HomeScreen(),
    ),
    _ => MaterialPageRoute(builder: (context) => LoginPage()),
  };
}
