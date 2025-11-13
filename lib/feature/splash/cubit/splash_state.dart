import 'package:flutter/material.dart';

abstract class SplashState {}

class SplashInitial extends SplashState {}

class SplashIntro extends SplashState {
  final Animation<double> scaleAnimation;
  SplashIntro({required this.scaleAnimation});
}

class SplashExpanding extends SplashState {
  final Animation<double> expandAnimation;
  SplashExpanding({required this.expandAnimation});
}

class SplashNavigateToHome extends SplashState {
  final bool isLoggedIn;
  SplashNavigateToHome({required this.isLoggedIn});
}
