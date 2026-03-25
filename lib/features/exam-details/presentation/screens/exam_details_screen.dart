import 'package:flutter/material.dart';

class ExamDetailsScreen extends StatelessWidget {
  static const String routeName = "exam-details-screen";
  const ExamDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final examId = ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
      appBar: AppBar(title: const Text("Exam")),
      body: Center(child: Text("Exam ID: $examId")),
    );
  }
}
