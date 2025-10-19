import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kheet_amal/core/utils/app_colors.dart';

class CustomSectionDivider extends StatelessWidget {
  const CustomSectionDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: AppColors.primaryColor,
      thickness: 1.h,
      height: 0,
      indent: 55.w,
      endIndent: 55.w,
    );
  }
}