import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kheet_amal/core/utils/app_colors.dart';
import 'package:kheet_amal/feature/home/data/models/report_model.dart';
import 'package:kheet_amal/feature/home/presentation/widgets/custom_founder_info.dart';
import 'package:kheet_amal/feature/home/presentation/widgets/custom_report_details_cards.dart';

Widget buildScreenshotContent(
    {required ReportModel report}
) {
    return Material(
      child: Container(
        color: AppColors.backgroundColor,
        padding: EdgeInsets.all(16.w),
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 400.w),
          child: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  alignment: Alignment.center,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15.sp),
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
                ),
                SizedBox(height: 20.h),
                FounderInfo(),
                ReportDetailsCardsColumn(report: report),
              ],
            ),
          ),
        ),
      ),
    );
  }
