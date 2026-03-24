import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_exam_app_v/config/di/di.dart';
import 'package:online_exam_app_v/core/widgets/primary_button.dart';
import 'package:online_exam_app_v/core/widgets/rich_text_with_link.dart';
import 'package:online_exam_app_v/feature/login/api/data_source/login_remote_data_source_imp.dart';
import 'package:online_exam_app_v/feature/login/data/models/login_request.dart';
import 'package:online_exam_app_v/feature/login/data/repositories/login_repo_imp.dart';
import 'package:online_exam_app_v/feature/login/domain/usecases/login_use_case.dart';
import 'package:online_exam_app_v/feature/login/persentation/cubit/login_view_model.dart';
import 'package:online_exam_app_v/features/home/presentation/screens/home_screen.dart';

class LoginPage extends StatefulWidget {
  static const String routeName = "login";
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  LoginViewModel viewModel = getIt.get<LoginViewModel>();
  final TextEditingController emailContorller = TextEditingController();
  final TextEditingController passwordContorller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          spacing: 24,
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Email',
                hintText: 'Enter your email',
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            TextField(
              decoration: InputDecoration(
                labelText: 'Paswword',
                hintText: 'Enter your password',
              ),
              keyboardType: TextInputType.visiblePassword,
            ),
            Row(
              children: [
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
                  child: PrimaryButton(onPressed: () {}, text: "Login"),
                ),
              ],
            ),
            RichTextWithLink(
              normalText: "Don't have an account?",
              linkText: ' Sign up',
              onLinkTap: () =>
                  Navigator.pushNamed(context, HomeScreen.routeName),
            ),
          ],
        ),
      ),
    );
  }
}
