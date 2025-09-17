import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kheet_amal/core/routing/app_routes.dart';
import 'package:kheet_amal/core/utils/app_colors.dart';
import 'package:kheet_amal/core/utils/app_images.dart';
import 'package:kheet_amal/feature/splash/cubit/splash_cubit.dart';
import 'package:kheet_amal/feature/splash/cubit/splash_state.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _introController;
  late AnimationController _expandController;

  @override
  void initState() {
    super.initState();
    _introController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _expandController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
  }

  @override
  void dispose() {
    _introController.dispose();
    _expandController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SplashCubit(
        introController: _introController,
        expandController: _expandController,
      ),
      child: BlocListener<SplashCubit, SplashState>(
        listener: (context, state) {
          if (state is SplashNavigateToHome) {
          //  Navigator.of(context).pushReplacementNamed(AppRoutes.home);
            Navigator.of(context).pushReplacementNamed(AppRoutes.forgetPass);
          }
        },
        child: Scaffold(
          backgroundColor: AppColors.backgroundColor,
          body: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Stack(
              alignment: Alignment.center,
              children: [
                BlocBuilder<SplashCubit, SplashState>(
                  builder: (context, state) {
                    if (state is SplashIntro) {
                      return ScaleTransition(
                        scale: state.scaleAnimation,
                        child: Image.asset(
                          AppImages.blob,
                          width: 365.w,
                          height: 405.h,
                        ),
                      );
                    } else if (state is SplashExpanding) {
                      return AnimatedBuilder(
                        animation: state.expandAnimation,
                        builder: (context, child) {
                          return Transform.scale(
                            scale: state.expandAnimation.value,
                            child: Image.asset(
                              AppImages.blob,
                              width: 365.w,
                              height: 405.h,
                            ),
                          );
                        },
                      );
                    }
                    return Container(
                      color: AppColors.primaryColor,
                      height: double.infinity,
                      width: double.infinity,
                    );
                  },
                ),
                Positioned(
                  bottom: 343.h,
                  child: Image.asset(
                    AppImages.kheetAmal,
                    width: 293.w,
                    height: 362.h,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
