import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam_app_v/config/di/di.dart';
import 'package:online_exam_app_v/core/theme/app_colors.dart';
import 'package:online_exam_app_v/core/theme/app_sizes.dart';
import 'package:online_exam_app_v/core/utilies/app_validators.dart';
import 'package:online_exam_app_v/core/widgets/primary_button.dart';
import 'package:online_exam_app_v/core/widgets/rich_text_with_link.dart';
import 'package:online_exam_app_v/features/login/presentation/screens/login_screen.dart';
import 'package:online_exam_app_v/features/register/presentation/view_model/cubit/register_view_model.dart';
import 'package:online_exam_app_v/features/register/presentation/view_model/states/register_events.dart';
import 'package:online_exam_app_v/features/register/presentation/view_model/states/register_states.dart';

@injectable
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
    _registerViewModel.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => _registerViewModel,
      child: BlocConsumer<RegisterViewModel, RegisterStates>(
        listenWhen: (previous, current) =>
            previous.registerState.errorMessage !=
                current.registerState.errorMessage ||
            previous.registerState.data != current.registerState.data,
        listener: (context, state) {
          final registerState = state.registerState;

          if (registerState.data != null && mounted) {
            Navigator.pushReplacementNamed(context, LoginScreen.routeName);
          }

          if (registerState.errorMessage != null) {
            ScaffoldMessenger.of(context)
              ..clearSnackBars()
              ..showSnackBar(
                SnackBar(content: Text(registerState.errorMessage!)),
              );

            _registerViewModel.doEvent(ClearRegisterErrorEvent());
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Navigator.pop(context),
              ),
              title: const Text('Sign up'),
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
                      TextFormField(
                        controller: _registerViewModel.usernameController,
                        onChanged: (_) => _registerViewModel.validateForm(),
                        textInputAction: TextInputAction.next,
                        decoration: const InputDecoration(
                          labelText: 'User name',
                          hintText: 'Enter your user name',
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
                              controller:
                                  _registerViewModel.firstNameController,
                              onChanged: (_) =>
                                  _registerViewModel.validateForm(),
                              decoration: const InputDecoration(
                                labelText: 'First name',
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
                              onChanged: (_) =>
                                  _registerViewModel.validateForm(),
                              decoration: const InputDecoration(
                                labelText: 'Last name',
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
                        decoration: const InputDecoration(labelText: 'Email'),
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
                              onChanged: (_) =>
                                  _registerViewModel.validateForm(),
                              decoration: const InputDecoration(
                                labelText: 'Password',
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
                              onChanged: (_) =>
                                  _registerViewModel.validateForm(),
                              decoration: const InputDecoration(
                                labelText: 'Confirm password',
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
                          labelText: 'Phone number',
                        ),
                        validator: (v) => AppValidators.compose([
                          (v) => AppValidators.required(v),
                          (v) => AppValidators.number(v),
                        ], v),
                      ),

                      SizedBox(height: AppSizes.h(40)),

                      BlocBuilder<RegisterViewModel, RegisterStates>(
                        buildWhen: (previous, current) =>
                            previous.registerState.isLoading !=
                            current.registerState.isLoading,
                        builder: (context, state) {
                          return PrimaryButton(
                            onPressed: _registerViewModel.isFormValid
                                ? () => _registerViewModel.doEvent(
                                    RegisterUserEvent(),
                                  )
                                : null,
                            text: 'Sign up',
                            isLoading: state.registerState.isLoading,
                          );
                        },
                      ),

                      SizedBox(height: AppSizes.h(24)),

                      RichTextWithLink(
                        normalText: "Already have an account? ",
                        linkText: "Login",
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
          );
        },
      ),
    );
  }
}
