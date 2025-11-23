import 'package:flutter/material.dart';
import 'package:kheet_amal/core/routing/app_routes.dart';
import 'package:kheet_amal/feature/ai_model/ai_model_screen.dart';
import 'package:kheet_amal/feature/auth/presentation/screens/login_screen.dart';
import 'package:kheet_amal/feature/auth/presentation/screens/register_screen.dart';
import 'package:kheet_amal/feature/home/data/models/report_model.dart';
import 'package:kheet_amal/feature/comments/presentation/screen/comments_screen.dart';
import 'package:kheet_amal/feature/home/presentation/screens/home_screen.dart';
import 'package:kheet_amal/feature/home_layout/presentation/pages/home_layout_page.dart';
import 'package:kheet_amal/feature/my_reports_screen/my_reports_screen.dart';
import 'package:kheet_amal/feature/notification/notification_screen.dart';
import 'package:kheet_amal/feature/onboarding/translate_screen.dart';
import 'package:kheet_amal/feature/settings/about_app.dart';
import 'package:kheet_amal/feature/settings/contact_page.dart';
import 'package:kheet_amal/feature/settings/faq_page.dart';
import 'package:kheet_amal/feature/settings/settings_home.dart';
import 'package:kheet_amal/feature/splash/presentation/splash_screen.dart';
import 'package:kheet_amal/feature/onboarding/onboarding_screen.dart';
import '../../feature/auth/forget_pass/screens/forget_pass_screen.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    print("On generate route: ${settings.name}");
    switch (settings.name) {
      case AppRoutes.splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case AppRoutes.onboarding:
        return MaterialPageRoute(builder: (_) => const OnboardingScreen());
      case AppRoutes.translation:
        return MaterialPageRoute(builder: (_) => const TranslateScreen());
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
      case AppRoutes.notifications:
        return MaterialPageRoute(builder: (_) => NotificationScreen());
      case AppRoutes.savedItems:
        return MaterialPageRoute(builder: (_) => MyReports());
      case AppRoutes.myReports:
        return MaterialPageRoute(builder: (_) => MyReports());
      case AppRoutes.comments:
        return MaterialPageRoute(builder: (_) => const CommentsPage());
      case AppRoutes.settings:
        return MaterialPageRoute(builder: (_) => const SettingsHome());
      case AppRoutes.faq:
        return MaterialPageRoute(builder: (_) => const FAQPage());
      case AppRoutes.contact:
        return MaterialPageRoute(builder: (_) => const ContactPage());
      case AppRoutes.about:
        return MaterialPageRoute(builder: (_) => const AboutAppPage());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(body: Center(child: Text('404 Not Found'))),
        );
    }
  }
}
