import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kheet_amal/core/utils/app_colors.dart';
import 'package:kheet_amal/feature/report_details/widgets/custom_founder_info.dart';
import 'package:kheet_amal/feature/report_details/widgets/custom_report_action_bar.dart';
import 'package:kheet_amal/feature/report_details/widgets/custom_report_details_cards.dart';

class ReportDetails extends StatelessWidget {
  const ReportDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('report_details').tr(),
        centerTitle: true,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 26.w),
            child: Image.asset(
              'assets/images/saved_icon.png',
              height: 23.sp,
              width: 19.sp,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 64.sp,
                width: double.infinity,
                color: AppColors.sGreen,
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                        child: Text(
                          "ai_hint",
                          textAlign: TextAlign.right,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400,
                            height: 1.5.h,
                          ),
                        ).tr(),
                      ),
                    ),
                    Image.asset(
                      "assets/images/report_details.png",
                      height: 25.sp,
                      width: 25.sp,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 14.h),
              Container(
                alignment: Alignment.center,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15.sp),
                  child: Image.asset(
                    "assets/images/boy_photo.png",
                    height: 271.sp,
                    width: 264.sp,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              FounderInfo(),
              ReportDetailsCardsColumn(),
              ReportActionBar(),
            ],
          ),
        ),
      ),
    );
  }
}

