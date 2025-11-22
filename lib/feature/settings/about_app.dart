import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AboutAppPage extends StatelessWidget {
  const AboutAppPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: Text(
          "about_app_info".tr(),
          style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.w),
        child: ListView(
          children: [
            Text(
              "about_us".tr(),
              textAlign: TextAlign.right,
              style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.h),
            Text(
              "about_us_desc".tr(),
              textAlign: TextAlign.right,
              style: TextStyle(fontSize: 20.sp),
            ),
            SizedBox(height: 20.h),
            Text(
              "our_goal".tr(),
              textAlign: TextAlign.right,
              style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.h),
            Text(
              "our_goal_desc".tr(),
              textAlign: TextAlign.right,
              style: TextStyle(fontSize: 20.sp),
            ),
            SizedBox(height: 20.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "app_info_title".tr(),
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.right,
                ),
                SizedBox(width: 10.w),
                Icon(Icons.phone_android, size: 28.sp),
              ],
            ),
            SizedBox(height: 20.h),
            Text(
              "app_version".tr(),
              textAlign: TextAlign.right,
              style: TextStyle(fontSize: 20.sp),
            ),
            Text(
              "app_developer".tr(),
              textAlign: TextAlign.right,
              style: TextStyle(fontSize: 20.sp),
            ),
          ],
        ),
      ),
    );
  }
}
