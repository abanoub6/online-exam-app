import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_exam_app_v/config/di/di.dart';
import 'package:online_exam_app_v/config/observer/bloc_observer.dart';
import 'package:online_exam_app_v/config/services/navigation_service.dart';
import 'package:online_exam_app_v/core/theme/app_theme.dart';
import 'package:online_exam_app_v/features/exam-details/presentation/screens/exam_details_screen.dart';
import 'package:online_exam_app_v/features/exams/presentation/screens/exams_screen.dart';
import 'package:online_exam_app_v/features/forgot_password/presentation/screens/forgot_password_screen.dart';
import 'package:online_exam_app_v/features/login/presentation/screens/login_screen.dart';
import 'package:online_exam_app_v/features/home/presentation/screens/home_screen.dart';
import 'package:online_exam_app_v/features/login/domain/use_cases/remember_me.dart';
import 'package:online_exam_app_v/features/profile/presentation/screens/profile_screen.dart';
import 'package:online_exam_app_v/features/register/presentation/screens/register_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await FlutterSecureStorage().deleteAll(); // ← أضف ده مؤقتاً
  Bloc.observer = AppBlocObserver();
  await configureDependencies();
  final rememberUseCase = getIt<RememberMeUseCase>();
  runApp(MyApp(await rememberUseCase.isRememberedMe()));
}

class MyApp extends StatelessWidget {
  const MyApp(this.isRememberedMe, {super.key});
  final bool? isRememberedMe;
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          navigatorKey: NavigationService.navigatorKey, // ← أضف ده
          theme: AppTheme.lightTheme(),
          debugShowCheckedModeBanner: false,
          initialRoute: isRememberedMe ?? false
              ? HomeScreen.routeName
              : LoginScreen.routeName,
          routes: {
            RegisterScreen.routeName: (context) => RegisterScreen(),
            ForgotPasswordScreen.routeName: (context) => ForgotPasswordScreen(),
            HomeScreen.routeName: (context) => HomeScreen(),
            ExamsScreen.routeName: (context) => ExamsScreen(),
            ExamDetailsScreen.routeName: (context) => ExamDetailsScreen(),
            LoginScreen.routeName: (context) => LoginScreen(),
            ProfileScreen.routeName: (context) => const ProfileScreen(),
          },
        );
      },
    );
  }
}
