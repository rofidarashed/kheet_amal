import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kheet_amal/core/routing/app_router.dart';
import 'package:kheet_amal/core/routing/app_routes.dart';
import 'package:kheet_amal/core/theme/app_theme.dart';
import 'package:kheet_amal/feature/auth/cubit/auth_cubit.dart';
import 'package:kheet_amal/feature/home/cubit/home_cubit.dart';
import 'package:kheet_amal/feature/home/data/repositories/report_repository.dart';
import 'package:kheet_amal/feature/saved/cubits/saved_reports_cubit/saved_reports_cubit.dart';
import 'package:kheet_amal/feature/support_reports/cubits/sup_reports_cubit/supprot_reports_cubit.dart';
import 'dart:ui' as ui;
import 'feature/home_layout/presentation/cubit/bottom_nav_cubit.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(
    EasyLocalization(
      supportedLocales: [Locale('en'), Locale('ar')],
      path: 'assets/translate',
      saveLocale: true,
      fallbackLocale: Locale('en'),
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
          providers: [
            BlocProvider(create: (context) => BottomNavCubit()),
            BlocProvider(
              create: (_) => HomeCubit(ReportRepository())..loadReports(),
            ),
            BlocProvider(create: (context) => SavedReportsCubit()),
            BlocProvider(create: (context) => SupportReportsCubit()),
            BlocProvider(create: (_) => AuthCubit()),
          ],
          child: MaterialApp(
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            initialRoute: AppRoutes.splash,
            onGenerateRoute: (settings) => AppRouter.generateRoute(settings),
            builder: (buildContext, widget) {
              return Directionality(
                textDirection: ui.TextDirection.ltr,
                child: widget!,
              );
            },
          ),
        );
      },
    );
  }
}
