import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as ui;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kheet_amal/core/utils/app_colors.dart';

Container customAddReportCard(
  BuildContext context, {
  required List<Widget> children,
}) {
  return Container(
    width: double.infinity,
    margin: EdgeInsets.symmetric(horizontal: 24.w, vertical: 6.h),
    padding: EdgeInsets.all(16.w),
    decoration: BoxDecoration(
      color: AppColors.white,
      borderRadius: BorderRadius.circular(25.r),
      border: Border.all(width: 0.3, color: AppColors.primaryColor),
    ),
    child: Directionality(
      textDirection: context.locale.languageCode == 'ar'
          ? ui.TextDirection.rtl
          : ui.TextDirection.ltr,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    ),
  );
}
