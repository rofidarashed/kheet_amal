import 'package:flutter/material.dart';
import 'package:kheet_amal/core/utils/app_colors.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(scaffoldBackgroundColor: AppColors.backgroundColor,
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.blue,
        brightness: Brightness.dark,
      ),
    );
  }
}
