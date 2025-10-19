import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kheet_amal/core/utils/app_colors.dart';

class ReportMetaInfoRow extends StatelessWidget {
  const ReportMetaInfoRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          'since'.tr(),
          style: TextStyle(
            color: AppColors.black,
            fontSize: 13.sp,
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(99.w, 0, 2, 0),
          child: Text(
            " احمد محمد",
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.black,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(right: 24.0.sp),
          child: Text("posted_by").tr(),
        ),
      ],
    );
  }
}