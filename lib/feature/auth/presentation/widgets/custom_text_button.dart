import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../core/utils/app_colors.dart';

class CustomTextButton extends StatelessWidget {
  final String actionText;
  final String questionText;
  final VoidCallback onTap;

  const CustomTextButton({
    super.key,
    required this.actionText,
    required this.questionText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        textDirection: context.locale.languageCode == 'ar'
            ? ui.TextDirection.rtl
            : ui.TextDirection.ltr,
        children: [
          Text(
            questionText.tr(),
            style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w400),
          ),
          SizedBox(width: 8.w),
          GestureDetector(
            onTap: onTap,
            child: Text(
              actionText.tr(),
              style: TextStyle(
                fontSize: 19.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.secondaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
