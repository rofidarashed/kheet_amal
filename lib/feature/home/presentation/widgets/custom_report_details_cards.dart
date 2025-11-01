// ignore_for_file: unnecessary_null_comparison

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kheet_amal/core/utils/app_colors.dart';
import 'package:kheet_amal/feature/home/data/models/report_model.dart';
import 'package:kheet_amal/feature/home/presentation/widgets/custom_info_row.dart';
import 'package:kheet_amal/feature/home/presentation/widgets/custom_section_divider.dart';

class ReportDetailsCardsColumn extends StatelessWidget {
  const ReportDetailsCardsColumn({super.key, required this.report});
  final ReportModel report;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 16.h),
        SizedBox(
          width: 390.w,
          child: Card(
            shape: RoundedRectangleBorder(
              side: BorderSide(color: AppColors.primaryColor, width: .5.w),
              borderRadius: BorderRadius.circular(25.r),
            ),
            elevation: 0,
            margin: EdgeInsets.symmetric(horizontal: 12.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InfoRow(label: 'name'.tr(), value: report.childName),
                Divider(
                  color: AppColors.primaryColor,
                  thickness: 1.h,
                  height: 0,
                  indent: 55.w,
                  endIndent: 55.w,
                ),
                InfoRow(
                  label: 'age'.tr(),
                  value: report.startAge == report.endAge
                      ? report.startAge.toString()
                      : '${report.startAge} - ${report.endAge}',
                ),
                CustomSectionDivider(),
                InfoRow(label: 'gender'.tr(), value: report.gender),
                CustomSectionDivider(),
                InfoRow(label: 'last_seen_place'.tr(), value: report.place),
                CustomSectionDivider(),
                InfoRow(
                  label: 'missing_date'.tr(),
                  value: report.date!.timeZoneName != null
                      ? DateFormat('yyyy-MM-dd').format(report.date!)
                      : '',
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 16.h),
        SizedBox(
          width: 390.w,
          child: Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
              side: BorderSide(color: AppColors.primaryColor, width: .5.w),
              borderRadius: BorderRadius.circular(25.r),
            ),
            margin: EdgeInsets.symmetric(horizontal: 12.w),
            child: Column(
              children: [
                InfoRow(label: 'description'.tr(), value: report.description),
                CustomSectionDivider(),
                InfoRow(
                  label: 'clothing_at_disappearance'.tr(),
                  value: report.clothes,
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 16.h),
        SizedBox(
          width: 390.w,
          child: Card(
            shape: RoundedRectangleBorder(
              side: BorderSide(color: AppColors.primaryColor, width: .5.w),
              borderRadius: BorderRadius.circular(25.r),
            ),
            elevation: 0,
            margin: EdgeInsets.symmetric(horizontal: 12.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InfoRow(label: 'eye_color'.tr(), value: report.eyeColor),
                CustomSectionDivider(),
                InfoRow(label: 'skin_color'.tr(), value: report.skinColor),
                CustomSectionDivider(),
                InfoRow(label: 'hair_color'.tr(), value: report.hairColor),
                CustomSectionDivider(),
                InfoRow(
                  label: 'special_marks'.tr(),
                  value: report.distinctiveMarks,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
