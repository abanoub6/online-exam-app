import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_exam_app_v/config/di/di.dart';
import 'package:online_exam_app_v/core/constants/app_strings.dart';
import 'package:online_exam_app_v/core/theme/app_colors.dart';
import 'package:online_exam_app_v/core/theme/app_sizes.dart';
import 'package:online_exam_app_v/core/theme/app_text_styles.dart';
import 'package:online_exam_app_v/features/explore/presentation/view_model/cubit/explor_view_model.dart';
import 'package:online_exam_app_v/features/explore/presentation/view_model/states/subject_states.dart';
import 'package:online_exam_app_v/features/explore/presentation/view_model/states/subject_events.dart';
import 'package:online_exam_app_v/features/explore/presentation/widgets/search_text_field.dart';
import 'package:online_exam_app_v/features/explore/presentation/widgets/subject_card.dart';

class ExploreScreen extends StatelessWidget {
  static const String routeName = AppStrings.exploreScreen;

  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ExplorViewModel>()..doEvent(GetSubjectEvent()),
      child: SafeArea(
        child: Scaffold(
          body: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: AppSizes.w(24)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: AppSizes.h(16)),
                    Text(
                      AppStrings.survey,
                      style: AppTextStyles.s20w500(AppColors.blue),
                    ),
                    SizedBox(height: AppSizes.h(16)),
                    Builder(
                      builder: (context) => SearchTextField(
                        onChanged: (value) {
                          context.read<ExplorViewModel>().doEvent(
                            SearchSubjectsEvent(value),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: AppSizes.h(24)),
                    Text(
                      AppStrings.browseBySubject,
                      style: AppTextStyles.s18w500(),
                    ),
                    SizedBox(height: AppSizes.h(16)),
                  ],
                ),
              ),
              Expanded(
                child: BlocBuilder<ExplorViewModel, SubjectState>(
                  builder: (context, state) {
                    if (state is GetSubjectLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (state is GetSubjectSuccess) {
                      return GridView.builder(
                        itemBuilder: (context, index) {
                          return SubjectCard(state.subject[index]);
                        },
                        itemCount: state.subject.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 1,
                              childAspectRatio: 1 / 0.26,
                            ),
                      );
                    }
                    return const SizedBox();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
