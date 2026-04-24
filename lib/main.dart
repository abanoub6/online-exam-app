import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:online_exam_app_v/config/di/di.dart';
import 'package:online_exam_app_v/config/observer/bloc_observer.dart';
import 'package:online_exam_app_v/config/services/navigation_service.dart';
import 'package:online_exam_app_v/core/theme/app_theme.dart';
import 'package:online_exam_app_v/features/exam-details/presentation/screens/exam_details_screen.dart';
import 'package:online_exam_app_v/features/exams/presentation/screens/examStartScreen.dart';
import 'package:online_exam_app_v/features/exam-details/presentation/screens/score_screen.dart';
import 'package:online_exam_app_v/features/exams/presentation/screens/exams_screen.dart';
import 'package:online_exam_app_v/features/forgot_password/presentation/screens/forgot_password_screen.dart';
import 'package:online_exam_app_v/features/login/presentation/screens/login_screen.dart';
import 'package:online_exam_app_v/features/home/presentation/screens/home_screen.dart';
import 'package:online_exam_app_v/features/login/domain/use_cases/remember_me.dart';
import 'package:online_exam_app_v/features/profile/presentation/screens/profile_screen.dart';
import 'package:online_exam_app_v/features/register/presentation/screens/register_screen.dart';
import 'package:online_exam_app_v/features/results/presentation/screens/result_screen_details.dart';
import 'package:online_exam_app_v/features/results/presentation/screens/results_list_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await FlutterSecureStorage().deleteAll(); // ← أضف ده مؤقتاً
  Bloc.observer = AppBlocObserver();
  await configureDependencies();
  final rememberUseCase = getIt<RememberMeUseCase>();
  await Hive.initFlutter(); // 👈 هتشتغل دلوقتي
  await Hive.openBox('exam_results_box'); // 👈 مهم جدًا
  runApp(MyApp(await rememberUseCase.isRememberedMe()));
}

class MyApp extends StatelessWidget {
  const MyApp(this.isRememberedMe, {super.key});
  final bool? isRememberedMe;
  @override
  Widget build(BuildContext context) {
    // Hive.box("exam_results_box").clear();
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          navigatorKey: NavigationService.navigatorKey, // ← أضف ده
          theme: AppTheme.lightTheme(),
          debugShowCheckedModeBanner: false,
          initialRoute:
              //  ExamDetailsScreen.routeName,
              isRememberedMe ?? false
              ? HomeScreen.routeName
              : LoginScreen.routeName,
          routes: {
            RegisterScreen.routeName: (context) => RegisterScreen(),
            ForgotPasswordScreen.routeName: (context) => ForgotPasswordScreen(),
            HomeScreen.routeName: (context) => HomeScreen(),
            ExamsScreen.routeName: (context) => ExamsScreen(),
            ExamDetailsScreen.routeName: (context) => ExamDetailsScreen(),

            ExamStartScreen.routeName: (context) => const ExamStartScreen(),
            LoginScreen.routeName: (context) => LoginScreen(),
            ProfileScreen.routeName: (context) => const ProfileScreen(),
            ScoreScreen.routeName: (context) => ScoreScreen(),
            ResultsListScreen.routeName: (context) => ResultsListScreen(),
            ResultsDetailsScreen.routeName: (context) => ResultsDetailsScreen(),
          },
        );
      },
    );
  }
}
