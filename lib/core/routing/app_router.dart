import 'package:flutter/material.dart';
import 'package:kheet_amal/core/routing/app_routes.dart';

class AppRouter {
  static Map<String, WidgetBuilder> routes = {
    AppRoutes.splash: (context) => const Scaffold(),
  };
}
