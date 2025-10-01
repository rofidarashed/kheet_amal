import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../core/utils/app_colors.dart';

class TermsAgreement extends StatelessWidget {
  const TermsAgreement({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(22.w, 10.h, 35.w, 32.h),
      child: Row(
        children: [
          Expanded(
            child: Row(
              children: [
                Text(
                  "agree_terms".tr(),
                  style: TextStyle(fontSize: 16.sp),
                ),
                Text(
                  "agree_on".tr(),
                  style: TextStyle(fontSize: 16.sp, color: AppColors.secondaryColor),

                ),
              ],
            ),
          ),
          Checkbox(
            value: true,
            onChanged: (value) {},
            activeColor: AppColors.secondaryColor,
          ),
        ],
      ),
    );
  }
}