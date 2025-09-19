import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kheet_amal/core/routing/app_routes.dart';

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
              buildPage(
                image: "assets/images/onboarding1.png",
                title: 'welcome_title'.tr(),
                subtitle: 'welcome_subtitle'.tr(),
                buttonText: 'next_button'.tr(),
                onPressed: () {
                  _controller.nextPage(
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.easeInOut,
                  );
                },
                skip: true,
              ),
              buildPage(
                image: "assets/images/onboarding2.png",
                title: 'search_title'.tr(),
                subtitle: 'search_subtitle'.tr(),
                buttonText: 'next_button'.tr(),
                onPressed: () {
                  _controller.nextPage(
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.easeInOut,
                  );
                },
                skip: true,
              ),
              buildPage(
                image: "assets/images/onboarding3.png",
                title: 'together_title'.tr(),
                subtitle: 'together_subtitle'.tr(),
                buttonText: 'get_started_button'.tr(),
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed(AppRoutes.home);
                },
                skip: true,
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
                          ? Colors.blue
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

  Widget buildPage({
    required String image,
    required String title,
    required String subtitle,
    required String buttonText,
    required VoidCallback onPressed,
    bool skip = false,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: 60.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Image.asset(
              image,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              children: [
                SizedBox(height: 30.h),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 32.sp,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 12.h),
                Text(
                  subtitle,
                  style: TextStyle(fontSize: 28.sp),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 40.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    skip
                        ? TextButton(
                            onPressed: () {
                              _controller.jumpToPage(2);
                            },
                            child: Text(
                              'skip'.tr(),
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 25.sp,
                              ),
                            ),
                          )
                        : SizedBox(width: 70.w),
                    ElevatedButton(
                      onPressed: onPressed,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.r),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: 30.w,
                          vertical: 12.h,
                        ),
                      ),
                      child: Text(
                        buttonText,
                        style: TextStyle(fontSize: 25.sp, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
