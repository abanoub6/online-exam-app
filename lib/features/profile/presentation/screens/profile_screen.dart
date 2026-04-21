import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_exam_app_v/config/di/di.dart';
import 'package:online_exam_app_v/core/constants/app_strings.dart';
import 'package:online_exam_app_v/core/theme/app_colors.dart';
import 'package:online_exam_app_v/core/theme/app_sizes.dart';
import 'package:online_exam_app_v/core/theme/app_text_styles.dart';
import 'package:online_exam_app_v/features/profile/presentation/screens/edit_profile_screen.dart';
import 'package:online_exam_app_v/features/profile/presentation/view_model/cubit/profile_view_model.dart';
import 'package:online_exam_app_v/features/profile/presentation/view_model/states/profile_events.dart';
import 'package:online_exam_app_v/features/profile/presentation/view_model/states/profile_state.dart';
import 'package:online_exam_app_v/features/profile/presentation/widgets/password_field.dart';
import 'package:online_exam_app_v/features/profile/presentation/widgets/profile_shimmer.dart';
import 'package:online_exam_app_v/features/profile/presentation/widgets/read_only_field.dart';

class ProfileScreen extends StatefulWidget {
  static const String routeName = AppStrings.profileScreen;
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ProfileViewModel cubit = getIt<ProfileViewModel>();

  @override
  void initState() {
    super.initState();
    cubit.doEvent(GetProfileEvent());
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
          title: Text(
            AppStrings.profile,
            style: AppTextStyles.s20w500(AppColors.black),
          ),
        ),
        body: BlocConsumer<ProfileViewModel, ProfileState>(
          listener: (context, state) {
            if (state is GetProfileFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.errorMessage),
                  backgroundColor: AppColors.red,
                ),
              );
            }
            if (state is EditProfileSuccess) {
              cubit.doEvent(GetProfileEvent());
            }
          },
          builder: (context, state) {
            if (state is GetProfileLoading) {
              return const ProfileShimmer();
            }

            final profile = state is GetProfileSuccess ? state.profile : null;

            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: AppSizes.h(24)),
              child: Column(
                children: [
                  SizedBox(height: AppSizes.h(24)),

                  CircleAvatar(
                    radius: AppSizes.h(50),
                    backgroundColor: AppColors.gray,
                    child: Icon(
                      Icons.person,
                      size: AppSizes.h(50),
                      color: AppColors.white,
                    ),
                  ),
                  SizedBox(height: AppSizes.h(32)),

                  ReadOnlyField(
                    label: AppStrings.username,
                    value: profile?.username ?? '',
                  ),
                  SizedBox(height: AppSizes.h(16)),

                  Row(
                    children: [
                      Expanded(
                        child: ReadOnlyField(
                          label: AppStrings.firstName,
                          value: profile?.firstName ?? '',
                        ),
                      ),
                      SizedBox(width: AppSizes.w(16)),
                      Expanded(
                        child: ReadOnlyField(
                          label: AppStrings.lastName,
                          value: profile?.lastName ?? '',
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: AppSizes.h(16)),

                  ReadOnlyField(
                    label: AppStrings.email,
                    value: profile?.email ?? '',
                  ),

                  SizedBox(height: AppSizes.h(16)),
                  PasswordField(profile: profile),
                  SizedBox(height: AppSizes.h(16)),

                  ReadOnlyField(
                    label: AppStrings.phone,
                    value: profile?.phone ?? '',
                  ),
                  SizedBox(height: AppSizes.h(40)),

                  SizedBox(
                    width: double.infinity,
                    height: AppSizes.h(56),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.gray,
                      ),
                      onPressed: profile == null
                          ? null
                          : () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => BlocProvider.value(
                                  value: cubit,
                                  child: EditProfileScreen(profile: profile),
                                ),
                              ),
                            ),
                      child: Text(
                        AppStrings.update,
                        style: AppTextStyles.s16w500(AppColors.white),
                      ),
                    ),
                  ),
                  SizedBox(height: AppSizes.h(24)),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
