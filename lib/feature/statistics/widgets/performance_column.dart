import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kheet_amal/core/utils/app_colors.dart';
import 'package:kheet_amal/core/utils/app_icons.dart';
import 'package:kheet_amal/feature/statistics/widgets/custom_performance_card.dart';
import 'package:kheet_amal/feature/statistics/widgets/stats_section.dart';

class PerformanceColumn extends StatelessWidget {
  const PerformanceColumn({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            CustomPerformanceCard(
              child: Row(
                children: [
                  SvgPicture.asset(AppIcons.timeIcon),
                  Column(
                    children: [
                      Text(
                        'response_time'.tr(),
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'from_report_to_first_interaction'.tr(),
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: AppColors.inactiveTrackbarColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: 46.w),
                  Text(
                    '24${"h".tr()}',
                    style: TextStyle(fontSize: 30.sp, color: AppColors.sBlue),
                  ),
                ],
              ),
            ),
            CustomPerformanceCard(
              child: Row(
                children: [
                  SvgPicture.asset(AppIcons.volunteerIcon),
                  Column(
                    children: [
                      Text(
                        'total_volunteers'.tr(),
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'active_users'.tr(),
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: AppColors.inactiveTrackbarColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: 46.w),
                  Column(
                    children: [
                      Text(
                        '1.244',
                        style: TextStyle(
                          fontSize: 30.sp,
                          color: AppColors.sBrown,
                        ),
                      ),
                      Text(
                        'growth_since_last_month'.tr(),
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: AppColors.sGreen,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            CustomPerformanceCard(
              child: Row(
                children: [
                  SvgPicture.asset(AppIcons.ratingIcon),
                  Column(
                    children: [
                      Text(
                        'app_rating'.tr(),
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'average_user_rating'.tr(),
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: AppColors.inactiveTrackbarColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: 46.w),
                  Text(
                    '4.8/5',
                    style: TextStyle(fontSize: 30.sp, color: AppColors.sPink),
                  ),
                ],
              ),
            ),
            CustomPerformanceCard(
              child: Padding(
                padding: EdgeInsets.only(left: 15.w),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'network_performance'.tr(),
                          style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'user_activity_metrics'.tr(),
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: AppColors.inactiveTrackbarColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 2.h),
                    StatsSection(title: 'new_reports_today'.tr(), value: '23'),
                    StatsSection(title: 'daily_views'.tr(), value: '2,341'),
                    StatsSection(title: 'interactions'.tr(), value: '567'),
                    StatsSection(title: 'active_usage_rate'.tr(), value: '78%'),
                  ],
                ),
              ),
            ),
            CustomPerformanceCard(
              child: Padding(
                padding: EdgeInsets.only(left: 15.w),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'ai_statistics'.tr(),
                          style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'ai_feature_usage'.tr(),
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: AppColors.inactiveTrackbarColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 2.h),
                    StatsSection(title: 'imagine_requests'.tr(), value: '156'),
                    StatsSection(title: 'matching_accuracy'.tr(), value: '99%'),
                    StatsSection(title: 'analyzed_images'.tr(), value: '2,341'),
                    StatsSection(
                      title: 'face_recognition_success'.tr(),
                      value: '94%',
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
