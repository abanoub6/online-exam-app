import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam_app_v/config/di/di.dart';
import 'package:online_exam_app_v/core/constants/app_strings.dart';
import 'package:online_exam_app_v/core/theme/app_colors.dart';
import 'package:online_exam_app_v/core/theme/app_sizes.dart';
import 'package:online_exam_app_v/core/utilies/app_validators.dart';
import 'package:online_exam_app_v/core/widgets/primary_button.dart';
import 'package:online_exam_app_v/core/widgets/rich_text_with_link.dart';
import 'package:online_exam_app_v/features/login/presentation/screens/login_screen.dart';
import 'package:online_exam_app_v/features/register/presentation/view_model/cubit/register_view_model.dart';
import 'package:online_exam_app_v/features/register/presentation/view_model/states/register_events.dart';
import 'package:online_exam_app_v/features/register/presentation/view_model/states/register_states.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName = "register";

  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late final RegisterViewModel _registerViewModel;

  @override
  void initState() {
    _registerViewModel = getIt.get<RegisterViewModel>();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => _registerViewModel,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
          title: const Text(AppStrings.signUp),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: AppSizes.w(24),
              vertical: AppSizes.h(16),
            ),
            child: Form(
              key: _registerViewModel.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // User name
                  TextFormField(
                    controller: _registerViewModel.usernameController,
                    onChanged: (_) => _registerViewModel.validateForm(),
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                      labelText: AppStrings.userName,
                      hintText: AppStrings.enterYourUserName,
                    ),
                    validator: (v) => AppValidators.compose([
                      (v) => AppValidators.required(v),
                      (v) => AppValidators.minLength(v, 3),
                    ], v),
                  ),
                  SizedBox(height: AppSizes.h(20)),

                  // First & Last Name
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _registerViewModel.firstNameController,
                          onChanged: (_) => _registerViewModel.validateForm(),
                          decoration: const InputDecoration(
                            labelText: AppStrings.firstName,
                          ),
                          validator: (v) => AppValidators.compose([
                            (v) => AppValidators.required(v),
                            (v) => AppValidators.minLength(v, 3),
                          ], v),
                        ),
                      ),
                      SizedBox(width: AppSizes.w(16)),
                      Expanded(
                        child: TextFormField(
                          controller: _registerViewModel.lastNameController,
                          onChanged: (_) => _registerViewModel.validateForm(),
                          decoration: const InputDecoration(
                            labelText: AppStrings.lastName,
                          ),
                          validator: (v) => AppValidators.compose([
                            (v) => AppValidators.required(v),
                            (v) => AppValidators.minLength(v, 3),
                          ], v),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: AppSizes.h(20)),

                  // Email
                  TextFormField(
                    controller: _registerViewModel.emailController,
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (_) => _registerViewModel.validateForm(),
                    decoration: const InputDecoration(
                      labelText: AppStrings.email,
                    ),
                    validator: (v) => AppValidators.compose([
                      (v) => AppValidators.required(v),
                      (v) => AppValidators.email(v),
                    ], v),
                  ),

                  SizedBox(height: AppSizes.h(20)),

                  // Password & Confirm
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _registerViewModel.passwordController,
                          obscureText: true,
                          onChanged: (_) => _registerViewModel.validateForm(),
                          decoration: const InputDecoration(
                            labelText: AppStrings.password,
                          ),
                          validator: (v) => AppValidators.compose([
                            (v) => AppValidators.required(v),
                            (v) => AppValidators.password(v),
                          ], v),
                        ),
                      ),
                      SizedBox(width: AppSizes.w(16)),
                      Expanded(
                        child: TextFormField(
                          controller:
                              _registerViewModel.confirmPasswordController,
                          obscureText: true,
                          onChanged: (_) => _registerViewModel.validateForm(),
                          decoration: const InputDecoration(
                            labelText: AppStrings.confirmPassword,
                          ),
                          validator: (v) => AppValidators.compose([
                            (v) => AppValidators.required(v),
                            (v) => AppValidators.confirmPassword(
                              v,
                              _registerViewModel.passwordController.text,
                            ),
                          ], v),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: AppSizes.h(20)),

                  // Phone
                  TextFormField(
                    controller: _registerViewModel.phoneController,
                    keyboardType: TextInputType.phone,
                    onChanged: (_) => _registerViewModel.validateForm(),
                    decoration: const InputDecoration(
                      labelText: AppStrings.phoneNumber,
                    ),
                    validator: (v) => AppValidators.compose([
                      (v) => AppValidators.required(v),
                      (v) => AppValidators.number(v),
                    ], v),
                  ),

                  SizedBox(height: AppSizes.h(40)),

                  // Primary Button داخل BlocConsumer
                  BlocConsumer<RegisterViewModel, RegisterStates>(
                    listenWhen: (previous, current) =>
                        previous.registerState.errorMessage !=
                            current.registerState.errorMessage ||
                        previous.registerState.data !=
                            current.registerState.data,
                    listener: (context, state) {
                      final registerState = state.registerState;
                      if (!mounted) return;
                      if (registerState.data != null) {
                        Navigator.pushReplacementNamed(
                          context,
                          LoginScreen.routeName,
                        );
                      }

                      if (registerState.errorMessage != null) {
                        ScaffoldMessenger.of(context)
                          ..clearSnackBars()
                          ..showSnackBar(
                            SnackBar(
                              content: Text(registerState.errorMessage!),
                            ),
                          );

                        _registerViewModel.doEvent(ClearRegisterErrorEvent());
                      }
                    },
                    builder: (context, state) {
                      return PrimaryButton(
                        onPressed: _registerViewModel.isFormValid
                            ? () => _registerViewModel.doEvent(
                                RegisterUserEvent(),
                              )
                            : null,
                        text: AppStrings.signUp,
                        isLoading: state.registerState.isLoading,
                      );
                    },
                  ),

                  SizedBox(height: AppSizes.h(24)),

                  RichTextWithLink(
                    normalText: AppStrings.alreadyHaveAnAccount,
                    linkText: AppStrings.login,
                    linkTextColor: AppColors.blue,
                    onLinkTap: () =>
                        Navigator.pushNamed(context, LoginScreen.routeName),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
