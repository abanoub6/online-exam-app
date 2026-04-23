import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_exam_app_v/core/constants/app_strings.dart';
import 'package:online_exam_app_v/core/theme/app_colors.dart';
import 'package:online_exam_app_v/core/theme/app_sizes.dart';
import 'package:online_exam_app_v/core/theme/app_text_styles.dart';
import 'package:online_exam_app_v/core/utilies/app_validators.dart';
import 'package:online_exam_app_v/core/widgets/primary_button.dart';
import 'package:online_exam_app_v/features/profile/data/models/edit_profile_request.dart';
import 'package:online_exam_app_v/features/profile/domain/entities/profile_entity.dart';
import 'package:online_exam_app_v/features/profile/presentation/screens/change_password_screen.dart';
import 'package:online_exam_app_v/features/profile/presentation/view_model/cubit/profile_view_model.dart';
import 'package:online_exam_app_v/features/profile/presentation/view_model/states/profile_events.dart';
import 'package:online_exam_app_v/features/profile/presentation/view_model/states/profile_state.dart';

class EditProfileScreen extends StatefulWidget {
  final ProfileEntity profile;
  const EditProfileScreen({super.key, required this.profile});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late final TextEditingController usernameController;
  late final TextEditingController firstNameController;
  late final TextEditingController lastNameController;
  late final TextEditingController phoneController;
  final formKey = GlobalKey<FormState>();
  late ProfileViewModel cubit;

  @override
  void initState() {
    super.initState();
    cubit = context.read<ProfileViewModel>();

    usernameController = TextEditingController(text: widget.profile.username);
    firstNameController = TextEditingController(text: widget.profile.firstName);
    lastNameController = TextEditingController(text: widget.profile.lastName);
    phoneController = TextEditingController(text: widget.profile.phone);
  }

  @override
  void dispose() {
    usernameController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  void _submitEdit() {
    if (!formKey.currentState!.validate()) return;

    cubit.doEvent(
      EditProfileEvent(
        EditProfileRequest(
          username: usernameController.text != widget.profile.username
              ? usernameController.text
              : null,
          firstName: firstNameController.text != widget.profile.firstName
              ? firstNameController.text
              : null,
          lastName: lastNameController.text != widget.profile.lastName
              ? lastNameController.text
              : null,
          phone: phoneController.text != widget.profile.phone
              ? phoneController.text
              : null,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          AppStrings.editProfile,
          style: AppTextStyles.s20w500(AppColors.black),
        ),
      ),
      body: BlocListener<ProfileViewModel, ProfileState>(
        listener: (context, state) {
          if (state is EditProfileSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(AppStrings.profileUpdatedSuccessfully),
                backgroundColor: AppColors.green,
              ),
            );
            Navigator.pop(context);
          } else if (state is EditProfileFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage),
                backgroundColor: AppColors.red,
              ),
            );
          }
        },
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: AppSizes.h(24)),
          child: Form(
            key: formKey,
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

                TextFormField(
                  controller: usernameController,
                  decoration: InputDecoration(
                    label: Text(
                      AppStrings.username,
                      style: AppTextStyles.s14w400(AppColors.black),
                    ),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    floatingLabelStyle: AppTextStyles.s14w400(AppColors.black),
                    filled: false,
                  ),
                  validator: (value) => AppValidators.required(
                    value,
                    message: AppStrings.pleaseEnterYourUsername,
                  ),
                ),
                SizedBox(height: AppSizes.h(16)),

                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: firstNameController,
                        decoration: InputDecoration(
                          label: Text(
                            AppStrings.firstName,
                            style: AppTextStyles.s14w400(AppColors.black),
                          ),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          floatingLabelStyle: AppTextStyles.s14w400(
                            AppColors.black,
                          ),
                          filled: false,
                        ),
                        validator: (value) => AppValidators.required(
                          value,
                          message: AppStrings.pleaseEnterYourFirstName,
                        ),
                      ),
                    ),
                    SizedBox(width: AppSizes.w(16)),
                    Expanded(
                      child: TextFormField(
                        controller: lastNameController,
                        decoration: InputDecoration(
                          label: Text(
                            AppStrings.lastName,
                            style: AppTextStyles.s14w400(AppColors.black),
                          ),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          floatingLabelStyle: AppTextStyles.s14w400(
                            AppColors.black,
                          ),
                          filled: false,
                        ),
                        validator: (value) => AppValidators.required(
                          value,
                          message: AppStrings.pleaseEnterYourLastName,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: AppSizes.h(16)),

                TextFormField(
                  initialValue: widget.profile.email,
                  readOnly: true,
                  decoration: InputDecoration(
                    label: Text(
                      AppStrings.email,
                      style: AppTextStyles.s14w400(AppColors.gray),
                    ),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    floatingLabelStyle: AppTextStyles.s14w400(AppColors.gray),
                    filled: false,
                  ),
                ),
                SizedBox(height: AppSizes.h(16)),

                TextFormField(
                  initialValue: '••••••',
                  readOnly: true,
                  obscureText: true,
                  decoration: InputDecoration(
                    label: Text(
                      AppStrings.password,
                      style: AppTextStyles.s14w400(AppColors.black),
                    ),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    floatingLabelStyle: AppTextStyles.s14w400(AppColors.black),
                    filled: false,
                    suffixIcon: TextButton(
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => BlocProvider.value(
                            value: cubit,
                            child: const ChangePasswordScreen(),
                          ),
                        ),
                      ),
                      child: Text(
                        AppStrings.change,
                        style: AppTextStyles.s12w500(AppColors.blue),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: AppSizes.h(16)),

                TextFormField(
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    label: Text(
                      AppStrings.phone,
                      style: AppTextStyles.s14w400(AppColors.black),
                    ),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    floatingLabelStyle: AppTextStyles.s14w400(AppColors.black),
                    filled: false,
                  ),
                  validator: (value) => AppValidators.required(
                    value,
                    message: AppStrings.pleaseEnterYourPhone,
                  ),
                ),
                SizedBox(height: AppSizes.h(40)),

                BlocBuilder<ProfileViewModel, ProfileState>(
                  builder: (context, state) {
                    final isLoading = state is EditProfileLoading;
                    return SizedBox(
                      width: double.infinity,
                      height: AppSizes.h(56),
                      child: PrimaryButton(
                        isLoading: isLoading,
                        text: AppStrings.update,
                        onPressed: isLoading ? null : _submitEdit,
                      ),
                    );
                  },
                ),
                SizedBox(height: AppSizes.h(24)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
