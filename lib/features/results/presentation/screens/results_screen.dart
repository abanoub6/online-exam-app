import 'package:flutter/material.dart';
import 'package:online_exam_app_v/core/theme/app_colors.dart';

class ResultsScreen extends StatelessWidget {
  const ResultsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.green,
        title: Text("results Screen"),
      ),
    );
  }
}
