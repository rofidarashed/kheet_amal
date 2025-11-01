import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kheet_amal/core/utils/app_colors.dart';

class FounderInfo extends StatelessWidget {
  const FounderInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(25.w, 0, 25.w, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            'since'.tr(),
            style: TextStyle(color: AppColors.black, fontSize: 13.sp),
          ),
          Spacer(),
          Text(
            " احمد محمد",
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.black,
            ),
          ),
    
          Text("posted_by").tr(),
        ],
      ),
    );
  }
}
