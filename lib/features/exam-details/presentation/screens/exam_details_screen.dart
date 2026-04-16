import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_exam_app_v/config/di/di.dart';
import 'package:online_exam_app_v/core/theme/app_colors.dart';
import 'package:online_exam_app_v/core/theme/app_sizes.dart';
import 'package:online_exam_app_v/core/theme/app_text_styles.dart';
import 'package:online_exam_app_v/core/widgets/primary_button.dart';
import 'package:online_exam_app_v/features/exam-details/data/models/socre_result.dart';
import 'package:online_exam_app_v/features/exam-details/presentation/screens/score_screen.dart';
import 'package:online_exam_app_v/features/exam-details/presentation/view_model/cubit/questions_view_model.dart';
import 'package:online_exam_app_v/features/exam-details/presentation/view_model/states/questions_events.dart';
import 'package:online_exam_app_v/features/exam-details/presentation/view_model/states/questions_states.dart';
import 'package:online_exam_app_v/features/exam-details/presentation/widgets/exam_app_bar.dart';
import 'package:online_exam_app_v/features/exam-details/presentation/widgets/show_time_out_dialog.dart';
import 'package:online_exam_app_v/features/exam-details/presentation/widgets/timer_widget.dart';

class ExamDetailsScreen extends StatefulWidget {
  static const String routeName = "questions-screen";

  const ExamDetailsScreen({super.key});

  @override
  State<ExamDetailsScreen> createState() => _ExamDetailsScreenState();
}

class _ExamDetailsScreenState extends State<ExamDetailsScreen> {
  late final QuestionsViewModel _viewModel;
  int _currentQuestionIndex = 0;
  String? _examTitle;

  @override
  void initState() {
    super.initState();
    _viewModel = getIt.get<QuestionsViewModel>();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final args =
          ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

      final examId = args?['examId'] as String?;
      if (examId != null) {
        _examTitle = args?['examTitle'] as String? ?? "Exam";
        _viewModel.doEvent(GetQuestionsOnExamEvent(examId));
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text("No Exam ID provided!")));
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _onTimeFinished() {
    final score = _viewModel.calculateScore();
    _viewModel.doEvent(ClearAnswersEvent());
    _currentQuestionIndex = 0;
    if (mounted) {
      _showTimeOutDialog(score);
    }
  }

  void _showTimeOutDialog(ScoreResult score) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => ShowTimeOutDialog(score: score),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _viewModel,
      child: Scaffold(
        appBar: ExamAppBar(
          title: _examTitle ?? "Exam",
          onBack: () => Navigator.pop(context),
          onTimeFinished: _onTimeFinished,
        ),

        body: BlocBuilder<QuestionsViewModel, QuestionsStates>(
          builder: (context, state) {
            final questions = state.questionsState.data ?? [];
            final isLoading = state.questionsState.isLoading;
            final error = state.questionsState.errorMessage;

            if (isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (error != null) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(error, style: AppTextStyles.s16w400(AppColors.red)),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        final args =
                            ModalRoute.of(context)?.settings.arguments as Map?;
                        final examId = args?['examId'] as String?;
                        if (examId != null) {
                          _viewModel.doEvent(GetQuestionsOnExamEvent(examId));
                        }
                      },
                      child: const Text("Try Again"),
                    ),
                  ],
                ),
              );
            }

            if (questions.isEmpty) {
              return const Center(child: Text("No questions found"));
            }

            final currentQuestion = questions[_currentQuestionIndex];

            return Padding(
              padding: EdgeInsets.all(AppSizes.w(24)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Progress Indicator
                  LinearProgressIndicator(
                    value: (_currentQuestionIndex + 1) / questions.length,
                    backgroundColor: AppColors.ligtGrey,
                    color: AppColors.blue,
                    minHeight: 8,
                  ),
                  SizedBox(height: AppSizes.h(12)),

                  // Question Counter
                  Text(
                    "Question ${_currentQuestionIndex + 1} of ${questions.length}",
                    style: AppTextStyles.s16w500(),
                  ),

                  SizedBox(height: AppSizes.h(24)),

                  // Question Text
                  Text(
                    currentQuestion.question,
                    style: AppTextStyles.s20w600(),
                  ),

                  SizedBox(height: AppSizes.h(32)),

                  // Answers List
                  Expanded(
                    child: ListView.builder(
                      itemCount: currentQuestion.answers.length,
                      itemBuilder: (context, index) {
                        print("1111111111"); // بتتطبع كل مره الزمن بيتغير
                        final answer = currentQuestion.answers[index];
                        final isSelected = _viewModel.isAnswerSelected(
                          currentQuestion.id,
                          answer.key,
                        );

                        return GestureDetector(
                          onTap: () => _viewModel.doEvent(
                            SelectAnswerEvent(
                              questionId: currentQuestion.id,
                              selectedAnswerKey: answer.key,
                            ),
                          ),
                          child: Container(
                            margin: EdgeInsets.only(bottom: AppSizes.h(12)),
                            padding: EdgeInsets.symmetric(
                              horizontal: AppSizes.w(16),
                              vertical: AppSizes.h(16),
                            ),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? AppColors.blue.withOpacity(0.08)
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: isSelected
                                    ? AppColors.blue
                                    : AppColors.ligtGrey,
                                width: isSelected ? 2 : 1,
                              ),
                            ),
                            child: Row(
                              children: [
                                Radio<String>(
                                  value: answer.key,
                                  groupValue: _viewModel.getSelectedAnswer(
                                    currentQuestion.id,
                                  ),
                                  onChanged: (_) => _viewModel.doEvent(
                                    SelectAnswerEvent(
                                      questionId: currentQuestion.id,
                                      selectedAnswerKey: answer.key,
                                    ),
                                  ),
                                  activeColor: AppColors.blue,
                                ),
                                Expanded(
                                  child: Text(
                                    answer.answer,
                                    style: AppTextStyles.s16w400(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  // Navigation Buttons
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: _currentQuestionIndex > 0
                              ? () => setState(() => _currentQuestionIndex--)
                              : null,
                          style: OutlinedButton.styleFrom(
                            backgroundColor: _currentQuestionIndex > 0
                                ? AppColors.white
                                : AppColors.gray.withValues(alpha: 0.2),
                            padding: EdgeInsets.symmetric(
                              vertical: AppSizes.h(16),
                            ),
                            side: const BorderSide(color: AppColors.blue),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(28),
                            ),
                          ),
                          child: Text(
                            "Back",
                            style: AppTextStyles.s16w600(AppColors.blue),
                          ),
                        ),
                      ),
                      SizedBox(width: AppSizes.w(16)),
                      Expanded(
                        child: PrimaryButton(
                          // زر Next يكون مفعل فقط لو المستخدم جاوب على السؤال الحالي
                          onPressed: _viewModel.canGoNext(currentQuestion.id)
                              ? () {
                                  if (_currentQuestionIndex <
                                      questions.length - 1) {
                                    setState(() => _currentQuestionIndex++);
                                  } else {
                                    // Submit Exam
                                    final score = _viewModel.calculateScore();
                                    _viewModel.doEvent(ClearAnswersEvent());
                                    _currentQuestionIndex = 0;

                                    Navigator.pushNamed(
                                      context,
                                      ScoreScreen.routeName,
                                      arguments: {
                                        "correct": score.correctAnswers,
                                        "incorrect":
                                            score.totalQuestions -
                                            score.correctAnswers,
                                        "percentage": score.scorePercentage,
                                      },
                                    );
                                  }
                                }
                              : null,
                          text: _currentQuestionIndex < questions.length - 1
                              ? "Next"
                              : "Submit",
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
