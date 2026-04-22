import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_exam_app_v/config/di/di.dart';
import 'package:online_exam_app_v/core/theme/app_colors.dart';
import 'package:online_exam_app_v/core/theme/app_sizes.dart';
import 'package:online_exam_app_v/core/theme/app_text_styles.dart';
import 'package:online_exam_app_v/features/exams/domain/models/exam_entity.dart';
import 'package:online_exam_app_v/features/exams/presentation/screens/examStartScreen.dart';
import 'package:online_exam_app_v/features/exams/presentation/view_model/cubit/exams_view_model.dart';
import 'package:online_exam_app_v/features/exams/presentation/view_model/states/exams_events.dart';
import 'package:online_exam_app_v/features/exams/presentation/view_model/states/exams_state.dart';

class ExamsScreen extends StatefulWidget {
  static const String routeName = "exams-screen";
  const ExamsScreen({super.key});

  @override
  State<ExamsScreen> createState() => _ExamsScreenState();
}

class _ExamsScreenState extends State<ExamsScreen> {
  final ExamsViewModel cubit = getIt<ExamsViewModel>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final subjectId = ModalRoute.of(context)!.settings.arguments as String;
      cubit.doEvent(GetExamsBySubjectEvent(subjectId));
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: cubit,
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(
          backgroundColor: AppColors.white,
          elevation: 0,
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: AppColors.black,
            ),
          ),
          title: Text(
            'Languages',
            style: AppTextStyles.s20w500(AppColors.black),
          ),
        ),
        body: BlocConsumer<ExamsViewModel, ExamsState>(
          listener: (context, state) {
            if (state is ExamsFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.errorMessage),
                  backgroundColor: AppColors.red,
                ),
              );
            }
          },
          builder: (context, state) {
            if (state is ExamsLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is ExamsSuccess) {
              if (state.exams.isEmpty) {
                return Center(
                  child: Text(
                    'No exams available',
                    style: AppTextStyles.s16w400(AppColors.black),
                  ),
                );
              }

              return ListView.builder(
                padding: EdgeInsets.symmetric(
                  horizontal: AppSizes.w(24),
                  vertical: AppSizes.h(16),
                ),
                itemCount: state.exams.length,
                itemBuilder: (context, index) =>
                    _ExamCard(exam: state.exams[index]),
              );
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }
}

class _ExamCard extends StatelessWidget {
  final ExamEntity exam;
  const _ExamCard({required this.exam});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: AppSizes.h(12)),
      child: InkWell(
        onTap: () => Navigator.pushNamed(
          context,
          ExamStartScreen.routeName,
          arguments: exam,
        ),
        borderRadius: BorderRadius.circular(AppSizes.r(12)),
        child: Container(
          padding: EdgeInsets.all(AppSizes.h(16)),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(AppSizes.r(12)),
            boxShadow: [
              BoxShadow(
                color: AppColors.black.withOpacity(0.1),
                blurRadius: AppSizes.r(8),
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              // صورة الـ exam
              Container(
                width: AppSizes.w(48),
                height: AppSizes.h(48),
                decoration: BoxDecoration(
                  color: AppColors.gray.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(AppSizes.r(8)),
                ),
                child: Icon(
                  Icons.assignment_outlined,
                  color: AppColors.blue,
                  size: AppSizes.h(24),
                ),
              ),
              SizedBox(width: AppSizes.w(12)),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      exam.title,
                      style: AppTextStyles.s16w500(AppColors.black),
                    ),
                    SizedBox(height: AppSizes.h(4)),
                    Text(
                      '${exam.numberOfQuestions} Question',
                      style: AppTextStyles.s12w400(AppColors.gray),
                    ),
                    SizedBox(height: AppSizes.h(4)),
                    Text(
                      'From: 1.00  To: ${exam.duration}.00',
                      style: AppTextStyles.s12w400(AppColors.gray),
                    ),
                  ],
                ),
              ),
              // الـ duration
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: AppSizes.w(8),
                  vertical: AppSizes.h(4),
                ),
                decoration: BoxDecoration(
                  color: AppColors.blue.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(AppSizes.r(8)),
                ),
                child: Text(
                  '${exam.duration} Minutes',
                  style: AppTextStyles.s12w400(AppColors.blue),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
