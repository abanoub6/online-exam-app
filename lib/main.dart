import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_exam_app_v/config/di/di.dart';
import 'package:online_exam_app_v/config/observer/bloc_observer.dart';
import 'package:online_exam_app_v/core/routes.dart';
import 'package:online_exam_app_v/core/theme/app_theme.dart';
import 'package:online_exam_app_v/features/login/domain/usecases/remember_me.dart';

import 'core/constants/screen_names.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = AppBlocObserver();
  configureDependencies();
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
          onGenerateRoute: onGenerateRoute,
          initialRoute: isRememberedMe??false ? ScreenNames.homeScreen : ScreenNames.loginScreen,
          // routes: {
          //   LoginPage.routeName: (context) => LoginPage(),
          //   RegisterScreen.routeName: (context) => RegisterScreen(),
          //   ForgetPasswordScreen.routeName: (context) => ForgetPasswordScreen(),
          //   HomeScreen.routeName: (context) => HomeScreen(),
          // },
        );
      },
    );
  }
}
