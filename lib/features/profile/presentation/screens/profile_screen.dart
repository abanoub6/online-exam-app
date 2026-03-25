import 'package:flutter/material.dart';
import 'package:online_exam_app_v/core/theme/app_colors.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.red,
        title: Text("profile Screen"),
      ),
    );
  }
}
