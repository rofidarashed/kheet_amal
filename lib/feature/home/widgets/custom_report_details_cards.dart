import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kheet_amal/core/utils/app_colors.dart';
import 'package:kheet_amal/feature/home/widgets/custom_info_row.dart';
import 'package:kheet_amal/feature/home/widgets/custom_section_divider.dart';

class ReportDetailsCardsColumn extends StatelessWidget {
  const ReportDetailsCardsColumn({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 16.h),
        SizedBox(
          width: 390.w,
          height: 245.h,
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
                InfoRow(label: 'name'.tr(), value: 'احمد'),
                Divider(
                  color: AppColors.primaryColor,
                  thickness: 1.h,
                  height: 0,
                  indent: 55.w,
                  endIndent: 55.w,
                ),
                InfoRow(label: 'age'.tr(), value: '20'),
                CustomSectionDivider(),
                InfoRow(label: 'gender'.tr(), value: "ذكر"),
                CustomSectionDivider(),
                InfoRow(label: 'last_seen_place'.tr(), value: 'هنا'),
                CustomSectionDivider(),
                InfoRow(label: 'missing_date'.tr(), value: '20-20-2020'),
              ],
            ),
          ),
        ),
        SizedBox(height: 16.h),
        SizedBox(
          height: 194.h,
          width: 390.w,
          child: Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
              side: BorderSide(
                color: AppColors.primaryColor,
                width: .5.w,
              ),
              borderRadius: BorderRadius.circular(25.r),
            ),
            margin: EdgeInsets.symmetric(horizontal: 12.w),
            child: Column(
              children: [
                InfoRow(
                  label: 'description'.tr(),
                  value:
                      'نينةرنمةسمنبنةنرنمرةنرةرةرةرةرنررنمرمرمرولاولامملاملاملانلانلاةلاةلاةلاىلاىلالاى',
                ),
                CustomSectionDivider(),
                InfoRow(
                  label: 'clothing_at_disappearance'.tr(),
                  value:
                      'نينةرنمةسمنبنةنرنمرةنرةرةرةرةرنررنمرمرمرولاولامملاملاملانلانلاةلاةلاةلاىلاىلالاى',
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 16.h),
        SizedBox(
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
                CustomSectionDivider(),
                InfoRow(label: 'skin_color'.tr(), value: '20'),
                CustomSectionDivider(),
                InfoRow(label: 'hair_color'.tr(), value: "ذكر"),
                CustomSectionDivider(),
                InfoRow(label: 'special_marks'.tr(), value: 'هنا'),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
