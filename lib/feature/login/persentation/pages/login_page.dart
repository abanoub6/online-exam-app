import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_exam_app_v/config/di/di.dart';
import 'package:online_exam_app_v/core/widgets/primary_button.dart';
import 'package:online_exam_app_v/core/widgets/rich_text_with_link.dart';
import 'package:online_exam_app_v/feature/login/data/models/login_request.dart';
import 'package:online_exam_app_v/feature/login/persentation/cubit/login_view_model.dart';
import 'package:online_exam_app_v/feature/login/persentation/states/login_events.dart';
import 'package:online_exam_app_v/feature/login/persentation/states/login_state.dart';
import 'package:online_exam_app_v/features/home/presentation/screens/home_screen.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // LoginViewModel viewModel = getIt.get<LoginViewModel>();
  final TextEditingController emailContorller = TextEditingController();
  final TextEditingController passwordContorller = TextEditingController();
  final GlobalKey<FormState> _formState = GlobalKey<FormState>();

  @override
  void dispose() {
    emailContorller.dispose();
    passwordContorller.dispose();
    super.dispose();
  }

  bool rememberMe = false;
  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginViewModel>(
      create: (context) => getIt<LoginViewModel>(),
      child: Builder(
        builder: (context) => Scaffold(
          appBar: AppBar(
            // leading: IconButton(
            //   icon: const Icon(Icons.arrow_back),
            //   onPressed: () => Navigator.pop(context),
            // ),
            title: Text('Login'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formState,
              child: Column(
                spacing: 24,
                children: [
                  TextField(
                    controller: emailContorller,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      hintText: 'Enter your email',
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  TextField(
                    controller: passwordContorller,
                    decoration: InputDecoration(
                      labelText: 'Paswword',
                      hintText: 'Enter your password',
                    ),
                    keyboardType: TextInputType.visiblePassword,
                  ),
                  Row(
                    children: [
                      Checkbox(
                        value: rememberMe,
                        tristate: true,
                        onChanged: (value) => setState(() {
                          rememberMe = value ?? false;
                        }),
                      ),
                      Text('Remember me'),
                      Spacer(),

                      GestureDetector(
                        onTap: () {},
                        child: Text(
                          'Forget password?',
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: BlocConsumer<LoginViewModel, LoginStates>(
                          listener: (context, state) {
                            log("blablabla");
                            log(state.loginState.toString());
                            if (state.loginState.data != null) {
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(builder: (context) => HomeScreen()),
                              // );
                              // Navigator.pushNamed(context, ScreenNames.homeScreen);
                              ScaffoldMessenger.of(
                                context,
                              ).showSnackBar(SnackBar(content: Text("Work")));
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    state.loginState.errorMessage ??
                                        "no error messeages",
                                  ),
                                ),
                              );
                            }
                          },
                          builder: (context, state) {
                            return PrimaryButton(
                              onPressed: () {
                                if (_formState.currentState!.validate()) {
                                  LoginRequest params = LoginRequest(
                                    email: emailContorller.text.trim(),
                                    password: passwordContorller.text,
                                    rememberMe: rememberMe,
                                  );
                                  context.read<LoginViewModel>().doEvent(
                                    LoginUserEvent(login: params),
                                  );
                                }
                              },
                              text: "Login",
                              isLoading: state.loginState.isLoading,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  RichTextWithLink(
                    normalText: "Don't have an account?",
                    linkText: ' Sign up ',
                    linkTextColor: Colors.blue,
                    onLinkTap: () =>
                        Navigator.pushNamed(context, HomeScreen.routeName),
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
