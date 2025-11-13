import 'package:bloc/bloc.dart';
import 'package:flutter/animation.dart';
import 'package:kheet_amal/core/utils/shared_prefs_helper.dart';
import 'package:kheet_amal/feature/splash/cubit/splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  final AnimationController introController;
  final AnimationController expandController;

  SplashCubit({required this.introController, required this.expandController})
    : super(SplashInitial()) {
    _startIntro();
  }

  void _startIntro() {
    final scaleAnimation = CurvedAnimation(
      parent: introController,
      curve: Curves.elasticOut,
    );

    emit(SplashIntro(scaleAnimation: scaleAnimation));

    introController.forward();

    introController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _startExpand();
      }
    });
  }

  void _startExpand() {
    final expandAnimation = Tween<double>(
      begin: 1.0,
      end: 20.0,
    ).animate(CurvedAnimation(parent: expandController, curve: Curves.easeIn));

    emit(SplashExpanding(expandAnimation: expandAnimation));
    expandController.forward();

    expandController.addStatusListener((status) async {
      if (status == AnimationStatus.completed) {
        await SharedPrefsHelper.init();
        final savedUid = SharedPrefsHelper.userId;

        // ✅ Emit navigation with login status
        emit(
          SplashNavigateToHome(
            isLoggedIn: savedUid != null && savedUid.isNotEmpty,
          ),
        );
      }
    });
  }
}
