import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kheet_amal/core/utils/app_colors.dart';
import 'package:kheet_amal/core/utils/app_icons.dart';

Widget customSearchfailed({required BuildContext context}) {
  return Column(
    children: [
      SizedBox(height: 68.h),
      Center(
        child: Image.asset(
          "assets/images/image.png",
          height: 205.h,
          width: 180.w,
        ),
      ),
      SizedBox(height: 67.h),
      Text(
        "change_governorate".tr(),
        textAlign: TextAlign.center,
        style: TextStyle(
          color: AppColors.black,
          fontSize: 20.sp,
          fontWeight: FontWeight.w400,
        ),
      ),
      SizedBox(height: 72.h),
      ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.secondaryColor,
          minimumSize: Size(307.w, 45.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40.r),
          ),
        ),
        child: Text(
          "reset_filters".tr(),
          style: TextStyle(
            color: AppColors.white,
            fontSize: 24.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      SizedBox(height: 22.h),
      ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.backgroundColor,
          minimumSize: Size(169.w, 24.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40.r),
          ),
          elevation: 0,
        ),
        child: Text(
          "show_latest_cases".tr(),
          style: TextStyle(
            color: AppColors.secondaryColor,
            fontSize: 22.sp,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    ],
  );
}