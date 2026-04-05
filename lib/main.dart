import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_exam_app_v/config/di/di.dart';
import 'package:online_exam_app_v/config/observer/bloc_observer.dart';
import 'package:online_exam_app_v/core/constants/app_api_param.dart';
import 'package:online_exam_app_v/core/theme/app_theme.dart';
import 'package:online_exam_app_v/features/exam-details/presentation/screens/exam_details_screen.dart';
import 'package:online_exam_app_v/features/exams/presentation/screens/exams_screen.dart';
import 'package:online_exam_app_v/features/forgot_password/presentation/screens/forgot_password_screen.dart';
import 'package:online_exam_app_v/features/forgot_password/presentation/screens/reset_password_screen.dart';
import 'package:online_exam_app_v/features/forgot_password/presentation/screens/verify_reset_code_screen.dart';
import 'package:online_exam_app_v/features/home/presentation/screens/home_screen.dart';
import 'package:online_exam_app_v/features/login/presentation/screens/login_screen.dart';
import 'package:online_exam_app_v/features/register/presentation/screens/register_screen.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = AppBlocObserver();

  const storage = FlutterSecureStorage();
  await storage.write(
    key: AppApiParam.token,
    value:
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY5Yzk0ZjdjY2ViMmM1OWY4NGE0MWI5NCIsInJvbGUiOiJ1c2VyIiwiaWF0IjoxNzc0OTEwODg2fQ.4xQW9qKdWQFuXkxMnFobYlFSyNf7AwS1IRBPl6qA76E",
  );

  await configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          theme: AppTheme.lightTheme(),
          debugShowCheckedModeBanner: false,
          initialRoute: HomeScreen.routeName,
          routes: {
            LoginScreen.routeName: (context) => LoginScreen(),
            RegisterScreen.routeName: (context) => RegisterScreen(),
            ForgotPasswordScreen.routeName: (context) => ForgotPasswordScreen(),
            VerifyResetCodeScreen.routeName: (context) =>
                VerifyResetCodeScreen(),
            ResetPasswordScreen.routeName: (context) => ResetPasswordScreen(),
            HomeScreen.routeName: (context) => HomeScreen(),
            ExamsScreen.routeName: (context) => ExamsScreen(),
            ExamDetailsScreen.routeName: (context) => ExamDetailsScreen(),
          },
        );
      },
    );
  }
}
