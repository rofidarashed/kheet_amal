import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kheet_amal/core/utils/app_colors.dart';
import 'package:kheet_amal/feature/home/data/models/report_model.dart';
import 'package:kheet_amal/feature/home/presentation/screens/report_details_screen.dart';
import 'package:kheet_amal/feature/home/presentation/widgets/custom_icon_button.dart';
import 'package:kheet_amal/feature/home/presentation/widgets/custom_report_action_bar.dart';
import 'info_row.dart';

class ChildCard extends StatelessWidget {
  const ChildCard({super.key, required this.theme, required this.report});

  final ThemeData theme;
  final ReportModel report;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ReportDetails(report: report),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
        ),
        padding: EdgeInsets.all(10.w),
        margin: EdgeInsets.only(bottom: 16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10.r),
                      child: report.imageUrl.isNotEmpty
                          ? Image.network(
                              report.imageUrl,
                              height: 187.h,
                              width: 158.w,
                              fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) => SvgPicture.asset(
                                'assets/svgs/profile_icon.svg',
                                height: 187.h,
                                width: 158.w,
                                fit: BoxFit.cover,
                              ),
                            )
                          : Container(),
                    ),
                    Positioned(
                      top: 4.h,
                      left: 4.w,
                      child: CircleAvatar(
                        radius: 14.r,
                        backgroundColor: Colors.white70,
                        child: Icon(
                          Icons.bookmark_border,
                          color: Colors.black87,
                          size: 16.sp,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SizedBox(height: 2.h),
                      InfoRow(label: 'name'.tr(), value: report.childName),
                      SizedBox(height: 6.h),
                      InfoRow(
                        label: 'age'.tr(),
                        value: report.startAge == report.endAge
                            ? report.startAge.toString()
                            : '${report.startAge} - ${report.endAge}',
                      ),
                      SizedBox(height: 6.h),
                      InfoRow(label: 'place'.tr(), value: report.place),
                      SizedBox(height: 6.h),
                      Text(
                        'since'.tr(),
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 13.sp,
                        ),
                        textAlign: TextAlign.right,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            ReportActionBar(
              onPressed: () {},
              actionChild: CustomIconButton(
                text: 'details'.tr(),
                backgroundColor: AppColors.secondaryColor,
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
