// ignore_for_file: unnecessary_null_comparison

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
      padding: EdgeInsets.fromLTRB(22.w, 12.h, 47.w, 16.h),
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(
                width: 12.w,
                height: 12.h,
                child: Checkbox(
                  value: value,
                  onChanged: onChanged,
                  activeColor: AppColors.secondaryColor,
                  checkColor: AppColors.white,
                ),
              ),
              SizedBox(width: 8.w),
              SizedBox(
                height: 30.h,
                child: Row(
                  children: [
                    Text("agree_on".tr(), style: TextStyle(fontSize: 16.sp)),
                    Text(
                      "agree_terms".tr(),
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: AppColors.secondaryColor,
                      ),
                      maxLines: 2,
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (checkboxValidator != null && checkboxValidator(value) != null)
            Padding(
              padding: EdgeInsets.only(left: 10.w, top: 5.h),
              child: Text(
                checkboxValidator(value)!,
                style: TextStyle(color: AppColors.red, fontSize: 12.sp),
              ),
            ),
        ],
      ),
    );
  }
}
