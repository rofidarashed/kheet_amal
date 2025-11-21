import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kheet_amal/core/utils/app_colors.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({
    super.key,
    required this.image,
    required this.title,
    required this.subtitle,
    required this.buttonText,
    required this.onPressed,
    required this.onSkip,
    this.skip = false,
  });

  final String image;
  final String title;
  final String subtitle;
  final String buttonText;
  final VoidCallback onPressed;
  final VoidCallback onSkip;
  final bool skip;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.zero,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: double.infinity,
            height: 500.h,
            child: Image.asset(image, fit: BoxFit.cover),
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

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                skip
                    ? TextButton(
                        onPressed: onSkip,
                        child: Text(
                          'skip'.tr(),
                          style: TextStyle(color: Colors.grey, fontSize: 25.sp),
                        ),
                      )
                    : SizedBox(width: 70.w),
                ElevatedButton(
                  onPressed: onPressed,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.secondaryColor,
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
}
