import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_exam_app_v/config/di/di.dart';
import 'package:online_exam_app_v/core/constants/app_strings.dart';
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

class ExamDetailsScreen extends StatefulWidget {
  final String examId;
  final String examTitle;

  const ExamDetailsScreen({
    super.key,
    required this.examId,
    required this.examTitle,
  });

  @override
  State<ExamDetailsScreen> createState() => _ExamDetailsScreenState();
}

class _ExamDetailsScreenState extends State<ExamDetailsScreen> {
  late final QuestionsViewModel _viewModel;
  int _currentQuestionIndex = 0;

  @override
  void initState() {
    super.initState();
    _viewModel = getIt<QuestionsViewModel>();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _viewModel.doEvent(GetQuestionsOnExamEvent(widget.examId));
    });
  }

  void _onTimeFinished() {
    final score = _viewModel.calculateScore();
    _viewModel.doEvent(SaveExamResults(score));
    _viewModel.doEvent(ClearAnswersEvent());
    _currentQuestionIndex = 0;

    _showTimeOutDialog(score);
  }

  void _showTimeOutDialog(ScoreResult score) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => ShowTimeOutDialog(
        score: score,
        examId: widget.examId,
        examTitle: widget.examTitle,
      ),
    );
  }

  void _goToScore(ScoreResult score) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => ScoreScreen(
          correct: score.correctAnswers,
          incorrect: score.totalQuestions - score.correctAnswers,
          percentage: score.scorePercentage,
          examId: widget.examId,
          examTitle: widget.examTitle,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<QuestionsViewModel>(
      create: (context) => _viewModel,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: BlocBuilder<QuestionsViewModel, QuestionsStates>(
            builder: (context, state) {
              final questions = state.questionsState.data;

              if (questions == null || questions.isEmpty) {
                return AppBar(
                  title: Text(widget.examTitle),
                  leading: IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () => Navigator.pop(context),
                  ),
                );
              }

              return ExamAppBar(
                timeInSeconds: questions[0].exam!.duration * 60,
                title: widget.examTitle,
                onBack: () => Navigator.pop(context),
                onTimeFinished: _onTimeFinished,
              );
            },
          ),
        ),

        /// 🔥 Body
        body: BlocBuilder<QuestionsViewModel, QuestionsStates>(
          builder: (context, state) {
            final questions = state.questionsState.data ?? [];
            final isLoading = state.questionsState.isLoading;
            final error = state.questionsState.errorMessage;

            if (isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (error != null) {
              return Center(child: Text(error));
            }

            if (questions.isEmpty) {
              return const Center(child: Text(AppStrings.noQuestionsFound));
            }

            final currentQuestion = questions[_currentQuestionIndex];

            return Padding(
              padding: EdgeInsets.all(AppSizes.w(24)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// 🔥 Progress
                  LinearProgressIndicator(
                    value: (_currentQuestionIndex + 1) / questions.length,
                    backgroundColor: AppColors.ligtGrey,
                    color: AppColors.blue,
                    minHeight: 8,
                  ),

                  SizedBox(height: AppSizes.h(12)),

                  Text(
                    "${AppStrings.questionOf} ${_currentQuestionIndex + 1} ${AppStrings.of} ${questions.length}",
                    style: AppTextStyles.s16w500(),
                  ),

                  SizedBox(height: AppSizes.h(24)),

                  /// 🔥 Question
                  Text(
                    currentQuestion.question,
                    style: AppTextStyles.s20w600(),
                  ),

                  SizedBox(height: AppSizes.h(32)),

                  /// 🔥 Answers
                  Expanded(
                    child: ListView.builder(
                      itemCount: currentQuestion.answers.length,
                      itemBuilder: (context, index) {
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
                                  ? AppColors.blue.withValues(alpha: 0.08)
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: isSelected
                                    ? AppColors.blue
                                    : AppColors.ligtGrey,
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

                  /// 🔥 Buttons
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: _currentQuestionIndex > 0
                              ? () => setState(() => _currentQuestionIndex--)
                              : null,
                          child: Text(
                            AppStrings.back,
                            style: AppTextStyles.s16w600(AppColors.blue),
                          ),
                        ),
                      ),
                      SizedBox(width: AppSizes.w(16)),
                      Expanded(
                        child: PrimaryButton(
                          onPressed: _viewModel.canGoNext(currentQuestion.id)
                              ? () {
                                  if (_currentQuestionIndex <
                                      questions.length - 1) {
                                    setState(() => _currentQuestionIndex++);
                                  } else {
                                    final score = _viewModel.calculateScore();
                                    _viewModel.doEvent(SaveExamResults(score));
                                    _goToScore(score);
                                  }
                                }
                              : null,
                          text: _currentQuestionIndex < questions.length - 1
                              ? AppStrings.next
                              : AppStrings.submit,
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
