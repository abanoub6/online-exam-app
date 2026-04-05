import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_exam_app_v/config/di/di.dart';
import 'package:online_exam_app_v/config/observer/bloc_observer.dart';
import 'package:online_exam_app_v/core/theme/app_theme.dart';
<<<<<<< HEAD
import 'package:online_exam_app_v/features/login/presentation/screens/login_screen.dart';
import 'package:online_exam_app_v/features/forget_password/presentation/screens/forget_password_screen.dart';
import 'package:online_exam_app_v/features/home/presentation/screens/home_screen.dart';
import 'package:online_exam_app_v/features/login/domain/use_cases/remember_me.dart';
import 'package:online_exam_app_v/features/register/presentation/screens/register_screen.dart';
=======
import 'package:online_exam_app_v/features/login/domain/usecases/remember_me.dart';
>>>>>>> 22589478c27956ed8f971823d66ac2b102068ab3

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
          theme: AppTheme.lightTheme(),
          debugShowCheckedModeBanner: false,
          initialRoute: isRememberedMe ?? false
              ? HomeScreen.routeName
              : LoginScreen.routeName,
          routes: {
            RegisterScreen.routeName: (context) => RegisterScreen(),
            ForgetPasswordScreen.routeName: (context) => ForgetPasswordScreen(),
            HomeScreen.routeName: (context) => HomeScreen(),
            LoginScreen.routeName: (context) => LoginScreen(),
          },
        );
      },
    );
  }
}
