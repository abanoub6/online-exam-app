import 'package:flutter/material.dart';
import 'package:online_exam_app_v/core/theme/app_colors.dart';
import 'package:online_exam_app_v/features/exam-details/presentation/screens/exam_details_screen.dart';

class ExamsScreen extends StatelessWidget {
  static const String routeName = "exams-screen";

  static const String examId = "69d980117c82914570305dd5";

  const ExamsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final subjectId = ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.gray,
        title: Text("Exams for $subjectId"),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Navigate لصفحة ExamScreen مع examId ثابت
            Navigator.pushNamed(
              context,
              ExamDetailsScreen.routeName,
              arguments: {'examId': examId, 'examTitle': "JS Basics"},
            );
          },
          child: const Text("Go to Exam"),
        ),
      ),
    );
  }
}
