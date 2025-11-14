import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kheet_amal/core/utils/app_images.dart';

import '../../../core/utils/app_colors.dart';

class savedCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20.r),
      ),
      width: 390.w,
      height: 240.h,
      child: Padding(
        padding: EdgeInsets.all(15.w),
        child: Column(
          children: [
            Row(
              children: [
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10.r),
                      child: Image.asset(AppImages.reportImage),
                    ),
                    Positioned(
                      top: 5.h,
                      left: 5.h,
                      child: Container(
                        width: 25.w,
                        height: 25.w,
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.bookmark,
                          color: AppColors.secondaryColor,
                          size: 22,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 20.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Name: Ahmed Mohamed".tr()),
                    Text("Age: 7".tr()),
                    Text("Location: New Egypt".tr()),
                    SizedBox(height: 10.h),
                    TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: AppColors.secondaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40.r),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: 12.w,
                          vertical: 8.h,
                        ),
                        fixedSize: Size(160.w, 32.h),
                      ),
                      onPressed: () {},
                      child: Text(
                        "Details".tr(),
                        style: TextStyle(
                          color: AppColors.white,
                          fontSize: 16.sp,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 7.h),
            Row(
              children: [
                Icon(Icons.favorite_border, color: AppColors.black, size: 20),
                SizedBox(width: 4.w),
                Text(
                  '20'.tr(),
                  style: TextStyle(color: AppColors.black, fontSize: 14.sp),
                ),
                SizedBox(width: 16.w),
                Icon(
                  Icons.mode_comment_outlined,
                  color: AppColors.black,
                  size: 20,
                ),
                SizedBox(width: 4.w),
                Text(
                  '20'.tr(),
                  style: TextStyle(color: AppColors.black, fontSize: 14.sp),
                ),
                Spacer(),
                Text(
                  "3 Days Ago".tr(),
                  style: TextStyle(
                    color: AppColors.inactiveTrackbarColor,
                    fontSize: 16.sp,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
