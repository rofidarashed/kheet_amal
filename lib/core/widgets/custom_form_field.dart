import 'dart:ui' as ui;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kheet_amal/core/utils/app_colors.dart';

class CustomFormField extends StatelessWidget {
  const CustomFormField({
    super.key,
    required this.title,
    required this.hint,
    this.validator,
    required this.controller,
    this.keyboardType,
    this.subtitle,
    this.maxLines,
    this.prefixIcon,
  });
  final String hint;
  final String? Function(String?)? validator;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final String title;
  final String? subtitle;
  final int? maxLines;
  final Widget? prefixIcon;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: context.locale.languageCode == 'ar'
          ? CrossAxisAlignment.start
          : CrossAxisAlignment.end,
      children: [
        subtitle == null
            ? Text(title, style: TextStyle(fontSize: 20.sp))
            : Directionality(
                textDirection: context.locale.languageCode == 'ar'
                    ? ui.TextDirection.rtl
                    : ui.TextDirection.ltr,
                child: Row(
                  children: [
                    Text(title, style: TextStyle(fontSize: 20.sp)),
                    SizedBox(width: 8.w),
                    Text(
                      subtitle ?? '',
                      style: TextStyle(color: AppColors.black, fontSize: 13.sp),
                    ),
                  ],
                ),
              ),
        SizedBox(height: 8.h),

        TextFormField(
          maxLines: maxLines ?? 1,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 10.w),
            filled: true,
            fillColor: AppColors.white,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.r),
              borderSide: BorderSide(color: AppColors.primaryColor, width: 1.w),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: AppColors.primaryColor, width: 2.w),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.r),
              borderSide: BorderSide(color: AppColors.primaryColor, width: 1.w),
            ),

            hint: Text(hint, style: TextStyle(color: AppColors.hintTextColor)),
            prefixIcon: prefixIcon,
          ),
          onTapOutside: (event) => FocusScope.of(context).unfocus(),
          keyboardType: keyboardType,
          validator: validator,
          controller: controller,
        ),
      ],
    );
  }
}
