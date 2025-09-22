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
              buildLastPage(
                image: "assets/images/onboarding3.png",
                title: 'together_title'.tr(),
                subtitle: 'together_subtitle'.tr(),
                buttonText: 'get_started_button'.tr(),
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed(AppRoutes.home);
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
                          ? Color(0xFF92C1EB)
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
      padding: EdgeInsets.all(0.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // الصورة بحجم معقول
          Container(
            width: 500.w,
            height: 500.h,
            child: Image.asset(image, fit: BoxFit.contain),
          ),

          SizedBox(height: 40.h),

          // العنوان
          Text(
            title,
            style: TextStyle(fontSize: 32.sp, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),

          SizedBox(height: 20.h),

          // النص الفرعي
          Text(
            subtitle,
            style: TextStyle(fontSize: 28.sp, color: Colors.grey[600]),
            textAlign: TextAlign.center,
          ),

          SizedBox(height: 40.h),

          // الزر ومؤشر التخطي
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                skip
                    ? TextButton(
                        onPressed: () {
                          _controller.jumpToPage(2);
                        },
                        child: Text(
                          'skip'.tr(),
                          style: TextStyle(color: Colors.grey, fontSize: 25.sp),
                        ),
                      )
                    : SizedBox(width: 70.w),

                ElevatedButton(
                  onPressed: onPressed,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFD7E00),
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
          ),
        ],
      ),
    );
  }

  Widget buildLastPage({
    required String image,
    required String title,
    required String subtitle,
    required String buttonText,
    required VoidCallback onPressed,
  }) {
    return Padding(
      padding: EdgeInsets.all(10.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 500.w,
            height: 400.h,
            child: Image.asset(image, fit: BoxFit.contain),
          ),

          SizedBox(height: 40.h),

          Text(
            title,
            style: TextStyle(fontSize: 32.sp, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),

          SizedBox(height: 20.h),

          Text(
            subtitle,
            style: TextStyle(fontSize: 28.sp, color: Colors.grey[600]),
            textAlign: TextAlign.center,
          ),

          SizedBox(height: 40.h),

          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 40.w),
            child: ElevatedButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFD7E00),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.r),
                ),
                padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 10.h),
                minimumSize: Size(double.infinity, 50.h),
              ),
              child: Text(
                buttonText,
                style: TextStyle(fontSize: 28.sp, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
