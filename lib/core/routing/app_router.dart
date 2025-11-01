import 'package:flutter/material.dart';
import 'package:kheet_amal/core/routing/app_routes.dart';
import 'package:kheet_amal/feature/auth/presentation/screens/login_screen.dart';
import 'package:kheet_amal/feature/auth/presentation/screens/register_screen.dart';
import 'package:kheet_amal/feature/comments/comments_screen.dart';
import 'package:kheet_amal/feature/forget_pass/screens/new_pass.dart';
import 'package:kheet_amal/feature/home/home_screen.dart';
import 'package:kheet_amal/feature/home_layout/presentation/pages/home_layout_page.dart';
import 'package:kheet_amal/feature/notification/notification_screen.dart';
import 'package:kheet_amal/feature/splash/presentation/splash_screen.dart';
import 'package:kheet_amal/feature/onboarding/onboarding_screen.dart';

import '../../feature/forget_pass/screens/forget_pass_screen.dart';
import '../../feature/forget_pass/screens/pass_success.dart';
import '../../feature/forget_pass/screens/verfiction_screen.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case AppRoutes.onboarding:
        return MaterialPageRoute(builder: (_) => const OnboardingScreen());
      case AppRoutes.login:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case AppRoutes.register:
        return MaterialPageRoute(builder: (_) => RegisterScreen());
      case AppRoutes.homeLayout:
        return MaterialPageRoute(builder: (_) => HomeLayoutPage());
      case AppRoutes.home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case AppRoutes.forgetPass:
        return MaterialPageRoute(builder: (_) => const ForgetPassScreen());
      case AppRoutes.verification:
        return MaterialPageRoute(
          builder: (_) => const VerificationScreen(phoneNumber: ''),
        );
      case AppRoutes.newPass:
        return MaterialPageRoute(builder: (_) => NewPasswordPage());
      case AppRoutes.passSuccess:
        return MaterialPageRoute(builder: (_) => PasswordResetSuccessScreen());
      case AppRoutes.notifications:
        return MaterialPageRoute(builder: (_) => NotificationScreen());
      case AppRoutes.comments:
        return MaterialPageRoute(builder: (_) => const CommentsPage());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(body: Center(child: Text('404 Not Found'))),
        );
    }
  }
}
