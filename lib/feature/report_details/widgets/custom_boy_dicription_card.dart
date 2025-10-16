import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kheet_amal/core/utils/app_colors.dart';
import 'package:kheet_amal/feature/home/widgets/info_row.dart';

class BoyDescriptionCard extends StatelessWidget {
  const BoyDescriptionCard({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 390.w,
      height: 200.h,
      child: Card(
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: AppColors.primaryColor,
            width: .5.w,
          ),
          borderRadius: BorderRadius.circular(25.r),
        ),
        elevation: 0,
        margin: EdgeInsets.symmetric(horizontal: 12.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InfoRow(label: 'eye_color'.tr(), value: 'احمد'),
            Divider(
              color: AppColors.primaryColor,
              thickness: 1.h,
              height: 0,
              indent: 55.w,
              endIndent: 55.w,
            ),
            InfoRow(label: 'skin_color'.tr(), value: '20'),
            Divider(
              color: AppColors.primaryColor,
              thickness: 1.h,
              height: 0,
              indent: 55.w,
              endIndent: 55.w,
            ),
            InfoRow(label: 'hair_color'.tr(), value: "ذكر"),
            Divider(
              color: AppColors.primaryColor,
              thickness: 1.h,
              height: 0,
              indent: 55.w,
              endIndent: 55.w,
            ),
            InfoRow(label: 'special_marks'.tr(), value: 'هنا'),
          ],
        ),
      ),
    );
  }
}