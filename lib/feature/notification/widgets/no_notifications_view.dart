import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:kheet_amal/core/utils/app_images.dart';

class NoNotificationsView extends StatelessWidget {
  const NoNotificationsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(32.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(AppImages.noNotification, width: 350.w),
            SizedBox(height: 20.h),
            Text(
              'no_notifications_title'.tr(),
              style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.h),
            Text(
              'no_notifications_subtitle'.tr(),
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20.sp),
            ),
          ],
        ),
      ),
    );
  }
}
