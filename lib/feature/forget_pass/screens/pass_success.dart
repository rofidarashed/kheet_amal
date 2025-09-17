import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:kheet_amal/feature/forget_pass/widgets/custom_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PasswordResetSuccessScreen extends StatelessWidget {
  const PasswordResetSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "password_reset_success.title".tr(),
          style: TextStyle(fontSize: 20.sp),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Gap(100.h),

            // Success Images
            Stack(
              children: [
                Center(
                  child: Image.asset(
                    'assets/images/green1.png',
                    width: 155.w,
                    height: 155.h,
                  ),
                ),
                Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 20.h),
                    child: Image.asset(
                      'assets/images/green2.png',
                      width: 116.w,
                      height: 116.h,
                    ),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: EdgeInsets.all(60.r),
                    child: Image.asset(
                      'assets/images/Vector(1).png',
                      width: 55.w,
                      height: 35.h,
                    ),
                  ),
                ),
              ],
            ),

            Gap(70.h),

            // Success Title
            Text(
              "password_reset_success.success_title".tr(),
              style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),

            Gap(16.h),

            // Success Description
            Text(
              "password_reset_success.success_description".tr(),
              style: TextStyle(
                fontSize: 18.sp,
                color: Colors.grey[700],
                height: 1.5,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),

            Gap(50.h),

            // Login Button
            CustomButton(
              text: "password_reset_success.login_button".tr(),
              onPressed: () {
                // TODO: Navigate to login screen
              },
            ),

            Gap(20.h),
          ],
        ),
      ),
    );
  }
}
