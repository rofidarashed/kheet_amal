import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kheet_amal/core/routing/app_routes.dart';
import 'package:kheet_amal/core/utils/app_colors.dart';
import 'package:kheet_amal/feature/onboarding/widgets/onboarding_page.dart';
import 'package:kheet_amal/feature/onboarding/widgets/onboarding_last_page.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int currentPage = 0;
  final int totalPages = 3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _controller,
            onPageChanged: (index) {
              setState(() => currentPage = index);
            },
            children: [
              OnboardingPage(
                image: "assets/images/onboarding1.png",
                title: 'welcome_title'.tr(),
                subtitle: 'welcome_subtitle'.tr(),
                buttonText: 'next_button'.tr(),
                skip: true,
                onPressed: () {
                  _controller.nextPage(
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.easeInOut,
                  );
                },
                onSkip: () {
                  _controller.jumpToPage(2);
                },
              ),
              OnboardingPage(
                image: "assets/images/onboarding2.png",
                title: 'search_title'.tr(),
                subtitle: 'search_subtitle'.tr(),
                buttonText: 'next_button'.tr(),
                skip: true,
                onPressed: () {
                  _controller.nextPage(
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.easeInOut,
                  );
                },
                onSkip: () {
                  _controller.jumpToPage(2);
                },
              ),
              OnboardingLastPage(
                image: "assets/images/onboarding3.png",
                title: 'together_title'.tr(),
                subtitle: 'together_subtitle'.tr(),
                buttonText: 'get_started_button'.tr(),
                onPressed: () {
                  Navigator.of(
                    context,
                  ).pushReplacementNamed(AppRoutes.register);
                },
              ),
            ],
          ),

          Positioned(
            bottom: 40.h,
            left: 20.w,
            right: 20.w,
            child: Row(
              children: List.generate(totalPages, (index) {
                return Expanded(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 4.w),
                    height: 6.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.r),
                      color: index == currentPage
                          ? AppColors.primaryColor
                          : Colors.grey[300],
                    ),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
