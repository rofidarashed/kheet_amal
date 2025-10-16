import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kheet_amal/core/utils/app_colors.dart';
import 'package:kheet_amal/feature/report_details/widgets/custom_icon_button.dart';

class ReportActionBar extends StatelessWidget {
  const ReportActionBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding:  EdgeInsets.only(left:25.w ),
            child: Row(
              children: [
                InkWell(
                  onTap: () {},
                  child: Image.asset(
                    "assets/images/heart_icon.png",
                    height: 20.h,
                    width: 20.w,
                  ),
                ),
                SizedBox(width: 5.w),
                Text('20', style: TextStyle(fontSize: 16.sp)),
                SizedBox(width: 25.w), 
                InkWell(
                  onTap: () {},
                  child: Image.asset(
                    "assets/images/messages_icon.png",
                    height: 20.h,
                    width: 20.w,
                  ),
                ),
                SizedBox(width: 5.w),
                Text('20', style: TextStyle(fontSize: 16.sp)),
              ],
            ),
          ),

          Padding(
            padding: EdgeInsets.fromLTRB(0, 16.h, 8.w, 28.h),
            child: CustomIconButton(
              text: 'share'.tr(),
              backgroundColor: AppColors.secondaryColor,
              onPressed: () {},
              icon: Icon(
                Icons.share,
                color: AppColors.white,
                size: 20.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }
}