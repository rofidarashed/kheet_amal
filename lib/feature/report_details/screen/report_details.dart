import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kheet_amal/core/utils/app_colors.dart';
import 'package:kheet_amal/feature/report_details/widgets/custom_report_action_bar.dart';
import 'package:kheet_amal/feature/report_details/widgets/custom_icon_button.dart';
import 'package:kheet_amal/feature/report_details/widgets/custom_info_row.dart';
import 'package:kheet_amal/feature/report_details/widgets/custom_section_divider.dart';

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
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'since'.tr(),
                    style: TextStyle(color: AppColors.black, fontSize: 13.sp),
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
              ),
              SizedBox(height: 16.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 22.0.sp),
                child: Row(
                  children: [
                    CustomIconButton(
                      text: 'contact'.tr(),
                      backgroundColor: AppColors.secondaryColor,
                      onPressed: () {},
                    ),
                    SizedBox(width: 12.w),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.r),
                        gradient: LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          colors: [
                            AppColors.magentaviolet,
                            AppColors.royalblue,
                          ],
                        ),
                      ),
                      child: CustomIconButton(
                        text: 'Ai ✦',
                        backgroundColor: Colors.transparent,
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
              ),
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
              ReportActionBar(),
            ],
          ),
        ),
      ),
    );
  }
}
