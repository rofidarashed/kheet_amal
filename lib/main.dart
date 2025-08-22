import 'package:flutter/material.dart';
import 'package:kheet_amal/core/routing/app_router.dart';
import 'package:kheet_amal/core/theme/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.lightTheme,
      routes: AppRouter.routes,
      home: const Scaffold(),
    );
  }
}
