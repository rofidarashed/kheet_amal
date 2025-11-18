import 'dart:ui' as ui;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kheet_amal/core/routing/app_routes.dart';
import 'package:kheet_amal/core/utils/app_colors.dart';
import 'package:kheet_amal/core/widgets/custom_button.dart';

class TranslateScreen extends StatelessWidget {
  const TranslateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 26.w, vertical: 87.h),
        child: Column(
          crossAxisAlignment: context.locale.languageCode == 'ar'
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,
          children: [
            Text(
              "choose_language".tr(),
              style: TextStyle(fontSize: 32.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.h),
            Text(
              "language_description".tr(),
              style: TextStyle(fontSize: 22.sp),
              textDirection: context.locale.languageCode == 'ar'
                  ? ui.TextDirection.rtl
                  : ui.TextDirection.ltr,
            ),
            SizedBox(height: 32.h),
            LangButton(
              onTap: () {
                context.setLocale(Locale('ar'));
              },
              isSelected: context.locale.languageCode == 'ar',
              title: "arabic".tr(),
            ),
            SizedBox(height: 24.h),
            LangButton(
              onTap: () {
                context.setLocale(Locale('en'));
              },
              isSelected: context.locale.languageCode == 'en',
              title: "english".tr(),
            ),
            Spacer(),
            Center(
              child: Text(
                "change_later".tr(),
                style: TextStyle(fontSize: 22.sp),
              ),
            ),
            SizedBox(height: 16.h),
            Center(
              child: CustomButton(
                text: "confirm_language".tr(),
                onPressed: () => Navigator.pushReplacementNamed(
                  context,
                  AppRoutes.onboarding,
                ),
              ),
            ),
            SizedBox(height: 100.h),
          ],
        ),
      ),
    );
  }
}

class LangButton extends StatelessWidget {
  const LangButton({
    super.key,
    required this.onTap,
    required this.isSelected,
    required this.title,
  });
  final VoidCallback onTap;
  final bool isSelected;
  final String title;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        alignment: context.locale.languageCode == 'ar'
            ? Alignment.centerRight
            : Alignment.centerLeft,
        height: 51.h,
        width: double.infinity,
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryColor : null,
          borderRadius: BorderRadius.circular(15.r),
          border: Border.all(color: AppColors.primaryColor),
        ),
        child: Text(
          "\t\t$title\t\t",
          style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
