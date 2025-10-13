import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kheet_amal/core/utils/app_colors.dart';

class OnboardingLastPage extends StatelessWidget {
  const OnboardingLastPage({
    super.key,
    required this.image,
    required this.title,
    required this.subtitle,
    required this.buttonText,
    required this.onPressed,
  });

  final String image;
  final String title;
  final String subtitle;
  final String buttonText;
  final VoidCallback onPressed;

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
                backgroundColor: AppColors.secondaryColor,
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
