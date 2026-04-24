import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_exam_app_v/config/di/di.dart';
import 'package:online_exam_app_v/features/exam-details/domain/entities/answer_entity.dart';
import 'package:online_exam_app_v/features/results/domain/enties/exam_result_entity.dart';
import 'package:online_exam_app_v/features/results/domain/enties/question_snap_shot_entity.dart';
import 'package:online_exam_app_v/features/results/presentation/screens/result_screen_details.dart';
import 'package:online_exam_app_v/features/results/presentation/view-model/cubit/results_view_mode.dart';
import 'package:online_exam_app_v/features/results/presentation/view-model/states/results_events.dart';
import 'package:online_exam_app_v/features/results/presentation/view-model/states/results_states.dart';

class ResultsListScreen extends StatefulWidget {
  static const routeName = "results-list";

  const ResultsListScreen({super.key});

  @override
  State<ResultsListScreen> createState() => _ResultsListScreenState();
}

class _ResultsListScreenState extends State<ResultsListScreen> {
  late final ResultsViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = getIt.get<ResultsViewModel>();
    _viewModel.doEvent(LoadResultsEvent());
  }

  @override
  Widget build(BuildContext context) {
    print("tessssssssssssssssssst");
    return BlocProvider.value(
      value: _viewModel,
      child: Scaffold(
        appBar: AppBar(title: const Text("Results")),
        body: BlocBuilder<ResultsViewModel, ResultsStates>(
          builder: (context, state) {
            final isLoading = state.resultsState.isLoading;
            final error = state.resultsState.errorMessage;
            final results =
                state.resultsState.data ??
                [
                  ExamResultEntity(
                    examId: "1",
                    examTitle: "High Level English",
                    correctAnswers: 18,
                    totalQuestions: 20,
                    percentage: 90,
                    questions: [
                      QuestionSnapshotEntity(
                        questionId: "q1",
                        question: "Choose the correct word:",
                        correctAnswerKey: "a",
                        selectedAnswer: "a",
                        answers: [
                          AnswerEntity(answer: "Apple", key: "a"),
                          AnswerEntity(answer: "Appl", key: "b"),
                          AnswerEntity(answer: "Aple", key: "c"),
                          AnswerEntity(answer: "Appel", key: "d"),
                        ],
                      ),
                      QuestionSnapshotEntity(
                        questionId: "q2",
                        question: "Fill in the blank:",
                        correctAnswerKey: "c",
                        selectedAnswer: "b",
                        answers: [
                          AnswerEntity(answer: "is", key: "a"),
                          AnswerEntity(answer: "are", key: "b"),
                          AnswerEntity(answer: "was", key: "c"),
                          AnswerEntity(answer: "were", key: "d"),
                        ],
                      ),
                    ],
                  ),
                ];

            if (isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (error != null) {
              return Center(child: Text(error));
            }

            if (results.isEmpty) {
              return const Center(child: Text("No Results Found"));
            }

            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: results.length,
              itemBuilder: (context, index) {
                final result = results[index];

                return GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      ResultsDetailsScreen.routeName,
                      arguments: result,
                    );
                  },
                  child: _buildResultCard(result),
                );
              },
            );
          },
        ),
      ),
    );
  }

  Widget _buildResultCard(result) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            const Icon(Icons.assignment, size: 40),

            const SizedBox(width: 16),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    result.examTitle,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 4),

                  Text("${result.totalQuestions} Questions"),

                  const SizedBox(height: 4),

                  Text(
                    "${result.correctAnswers} correct answers",
                    style: const TextStyle(color: Colors.blue),
                  ),
                ],
              ),
            ),

            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Text("30 Minutes"), // 👈 لو عايز تجيبها من entity بعدين

                const SizedBox(height: 8),

                Text(
                  "${result.percentage.toStringAsFixed(1)}%",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
