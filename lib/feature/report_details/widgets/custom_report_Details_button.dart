import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kheet_amal/core/utils/app_colors.dart';
import 'package:kheet_amal/feature/report_details/widgets/custom_icon_button.dart';

class ReportDetailsButton extends StatelessWidget {
  const ReportDetailsButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
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
    );
  }
}