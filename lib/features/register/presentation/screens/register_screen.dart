import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam_app_v/config/di/di.dart';
import 'package:online_exam_app_v/core/theme/app_colors.dart';
import 'package:online_exam_app_v/core/theme/app_sizes.dart';
import 'package:online_exam_app_v/core/utilies/validators.dart';
import 'package:online_exam_app_v/core/widgets/primary_button.dart';
import 'package:online_exam_app_v/core/widgets/rich_text_with_link.dart';
import 'package:online_exam_app_v/features/login/presentation/screens/login_screen.dart';
import 'package:online_exam_app_v/features/register/data/models/register_request.dart';
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
  final _formKey = GlobalKey<FormState>();

  final _userNameController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _phoneController = TextEditingController();

  late final RegisterViewModel _registerViewModel;

  @override
  void initState() {
    super.initState();
    // Injectable DI
    _registerViewModel = getIt.get<RegisterViewModel>();
  }

  @override
  void dispose() {
    _registerViewModel.close();
    _userNameController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _signUp() {
    if (_formKey.currentState!.validate()) {
      final request = RegisterRequest(
        username: _userNameController.text,
        firstName: _firstNameController.text,
        lastName: _lastNameController.text,
        email: _emailController.text,
        password: _passwordController.text,
        phone: _phoneController.text,
        rePassword: _confirmPasswordController.text,
      );

      _registerViewModel.doEvent(RegisterUserEvent(request));
    }
  }

  bool _isFormValid = false;
  void _validateForm() {
    final isValid = _formKey.currentState?.validate() ?? false;

    if (isValid != _isFormValid) {
      setState(() {
        _isFormValid = isValid;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RegisterViewModel>(
      create: (context) => _registerViewModel,
      child: BlocListener<RegisterViewModel, RegisterStates>(
        listenWhen: (previous, current) =>
            previous.registerState.errorMessage !=
                current.registerState.errorMessage ||
            previous.registerState.data != current.registerState.data,
        listener: (context, state) {
          final registerState = state.registerState;

          if (registerState.data != null && mounted) {
            Navigator.pushReplacementNamed(context, LoginScreen.routeName);
            return;
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

        child: Scaffold(
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
                key: _formKey,
                child: BlocBuilder<RegisterViewModel, RegisterStates>(
                  builder: (context, state) {
                    final isLoading = state.registerState.isLoading;

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Username
                        TextFormField(
                          onChanged: (_) => _validateForm(),
                          textInputAction: TextInputAction.next,
                          controller: _userNameController,
                          decoration: const InputDecoration(
                            labelText: 'User name',
                            hintText: 'Enter your user name',
                          ),
                          validator: (v) => Validators.compose([
                            (v) => Validators.required(v),
                            (v) => Validators.minLength(v, 3),
                          ], v),
                        ),
                        SizedBox(height: AppSizes.h(20)),

                        // First & Last name
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                onChanged: (_) => _validateForm(),
                                textInputAction: TextInputAction.next,

                                controller: _firstNameController,
                                decoration: const InputDecoration(
                                  labelText: 'First name',
                                ),
                                validator: (v) => Validators.compose([
                                  (v) => Validators.required(v),
                                  (v) => Validators.minLength(v, 3),
                                ], v),
                              ),
                            ),
                            SizedBox(width: AppSizes.w(16)),
                            Expanded(
                              child: TextFormField(
                                onChanged: (_) => _validateForm(),
                                controller: _lastNameController,
                                decoration: const InputDecoration(
                                  labelText: 'Last name',
                                ),
                                validator: (v) => Validators.compose([
                                  (v) => Validators.required(v),
                                  (v) => Validators.minLength(v, 3),
                                ], v),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: AppSizes.h(20)),

                        // Email
                        TextFormField(
                          onChanged: (_) => _validateForm(),
                          textInputAction: TextInputAction.next,

                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(labelText: 'Email'),
                          validator: (v) => Validators.compose([
                            (v) => Validators.required(v),
                            (v) => Validators.email(v),
                          ], v),
                        ),
                        SizedBox(height: AppSizes.h(20)),

                        // Password + Confirm Password
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                onChanged: (_) => _validateForm(),
                                textInputAction: TextInputAction.next,

                                controller: _passwordController,
                                obscureText: true,
                                decoration: const InputDecoration(
                                  labelText: 'Password',
                                ),
                                validator: (v) => Validators.compose([
                                  (v) => Validators.required(v),
                                  (v) => Validators.password(v),
                                ], v),
                              ),
                            ),
                            SizedBox(width: AppSizes.w(16)),
                            Expanded(
                              child: TextFormField(
                                onChanged: (_) => _validateForm(),
                                textInputAction: TextInputAction.next,

                                controller: _confirmPasswordController,
                                obscureText: true,
                                decoration: const InputDecoration(
                                  labelText: 'Confirm password',
                                ),
                                validator: (v) => Validators.compose([
                                  (v) => Validators.required(v),
                                  (v) => Validators.confirmPassword(
                                    v,
                                    _passwordController.text,
                                  ),
                                ], v),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: AppSizes.h(20)),

                        // Phone
                        TextFormField(
                          onChanged: (_) => _validateForm(),
                          controller: _phoneController,
                          keyboardType: TextInputType.phone,
                          decoration: const InputDecoration(
                            labelText: 'Phone number',
                          ),
                          validator: (v) => Validators.compose([
                            (v) => Validators.required(v),
                            (v) => Validators.number(v),
                          ], v),
                        ),
                        SizedBox(height: AppSizes.h(40)),

                        // Sign up button
                        PrimaryButton(
                          onPressed: _isFormValid ? _signUp : null,
                          text: 'Sign up',
                          isLoading: isLoading,
                        ),
                        SizedBox(height: AppSizes.h(24)),

                        // Already have an account? Login
                        RichTextWithLink(
                          normalText: "Already have an account? ",
                          linkText: "Login",
                          linkTextColor: AppColors.blue,
                          onLinkTap: () => Navigator.pushNamed(
                            context,
                            LoginScreen.routeName,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
