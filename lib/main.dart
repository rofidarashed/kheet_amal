import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kheet_amal/core/routing/app_router.dart';
import 'package:kheet_amal/core/routing/app_routes.dart';
import 'package:kheet_amal/core/theme/app_theme.dart';

import 'feature/home_layout/presentation/cubit/bottom_nav_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    EasyLocalization(
      supportedLocales: [Locale('en'), Locale('en')],
      path: 'assets/translate',
      saveLocale: true,
      fallbackLocale: Locale('ar'),
      startLocale: Locale('ar'),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(440, 956),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return MultiBlocProvider(
          providers: [BlocProvider(create: (context) => BottomNavCubit())],
          child: MaterialApp(
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            initialRoute: AppRoutes.homeLayout,
            onGenerateRoute: (settings) => AppRouter.generateRoute(settings),
          ),
        );
      },
    );
  }
}
