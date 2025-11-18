// ignore_for_file: unnecessary_null_comparison

import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../core/utils/app_colors.dart';

class TermsAgreement extends StatelessWidget {
  const TermsAgreement({
    super.key,
    required this.value,
    required this.onChanged,
    required this.checkboxValidator,
  });
  final bool value;
  final ValueChanged<bool?> onChanged;
  final FormFieldValidator<bool> checkboxValidator;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(40.w, 12.h, 47.w, 16.h),
      child: Column(
        children: [
          Row(
            textDirection: context.locale.languageCode == 'ar'
                ? ui.TextDirection.rtl
                : ui.TextDirection.ltr,
            children: [
              SizedBox(
                width: 12.w,
                height: 12.h,
                child: Checkbox(
                  value: value,
                  onChanged: onChanged,
                  activeColor: AppColors.secondaryColor,
                  checkColor: AppColors.white,
                  side: BorderSide(color: AppColors.secondaryColor, width: 1.5),
                ),
              ),
              SizedBox(width: 10.w),
              Flexible(
                child: RichText(
                  textDirection: context.locale.languageCode == 'ar'
                      ? ui.TextDirection.rtl
                      : ui.TextDirection.ltr,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "agree_on".tr() + " ",
                        style: TextStyle(fontSize: 16.sp, color: Colors.black),
                      ),
                      TextSpan(
                        text: "agree_terms".tr(),
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: AppColors.secondaryColor,
                        ),
                      ),
                    ],
                  ),
                  maxLines: 2,
                ),
              ),
            ],
          ),
          if (checkboxValidator != null && checkboxValidator(value) != null)
            Padding(
              padding: EdgeInsets.only(left: 10.w, top: 5.h, right: 20.w),
              child: SizedBox(
                width: double.infinity,
                child: Text(
                  textDirection: context.locale.languageCode == 'ar'
                      ? ui.TextDirection.rtl
                      : ui.TextDirection.ltr,
                  checkboxValidator(value)!,
                  style: TextStyle(color: AppColors.red, fontSize: 12.sp),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
