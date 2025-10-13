import 'dart:ui' as io;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kheet_amal/core/utils/app_colors.dart';

class CustomPerformanceCard extends StatelessWidget {
  const CustomPerformanceCard({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: context.locale == const Locale('ar')
          ? io.TextDirection.rtl
          : io.TextDirection.ltr,
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.only(top: 15.h),
        padding: EdgeInsets.fromLTRB(0, 15.h, 15.w, 15.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15.r),
          border: Border.all(color: AppColors.primaryColor, width: 1.w),
        ),
        child: child,
      ),
    );
  }
}
