import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_exam_app_v/config/di/di.dart';
import 'package:online_exam_app_v/core/constants/app_strings.dart';
import 'package:online_exam_app_v/core/theme/app_colors.dart';
import 'package:online_exam_app_v/core/theme/app_sizes.dart';
import 'package:online_exam_app_v/core/theme/app_text_styles.dart';
import 'package:online_exam_app_v/features/exams/presentation/view_model/cubit/exams_view_model.dart';
import 'package:online_exam_app_v/features/exams/presentation/view_model/states/exams_events.dart';
import 'package:online_exam_app_v/features/exams/presentation/view_model/states/exams_state.dart';
import 'package:online_exam_app_v/features/exams/presentation/widgets/exam_card.dart';
import 'package:online_exam_app_v/features/exams/presentation/widgets/exams_shimmer.dart';

class ExamsScreen extends StatefulWidget {
  static const String routeName = AppStrings.examsScreen;
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
        // backgroundColor: AppColors.white,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: AppColors.black,
            ),
          ),
          titleSpacing: 0,
          title: Text(
            AppStrings.languages,
            style: AppTextStyles.s20w500(AppColors.black),
          ),
        ),
        body: BlocConsumer<ExamsViewModel, ExamsStates>(
          listener: (context, state) {
            if (state.examsState.isLoading) return;

            if (state.examsState.errorMessage != null) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.examsState.errorMessage!),
                  backgroundColor: AppColors.red,
                ),
              );
            }
          },
          builder: (context, state) {
            if (state.examsState.isLoading) {
              return const ExamsShimmer();
            }

            if (state.examsState.data != null) {
              if (state.examsState.data!.isEmpty) {
                return Center(
                  child: Text(
                    AppStrings.noExamsAvailable,
                    style: AppTextStyles.s16w400(AppColors.black),
                  ),
                );
              }
              return ListView.builder(
                padding: EdgeInsets.symmetric(
                  horizontal: AppSizes.w(16),
                  vertical: AppSizes.h(16),
                ),
                itemCount: state.examsState.data!.length,
                itemExtent: AppSizes.h(120),
                itemBuilder: (context, index) =>
                    ExamCard(exam: state.examsState.data![index]),
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
