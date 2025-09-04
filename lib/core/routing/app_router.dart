import 'package:flutter/material.dart';
import 'package:kheet_amal/core/routing/app_routes.dart';
import 'package:kheet_amal/feature/home/home_screen.dart';
import 'package:kheet_amal/feature/splash/presentation/splash_screen.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case AppRoutes.home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(body: Center(child: Text('404 Not Found'))),
        );
    }
  }
}
