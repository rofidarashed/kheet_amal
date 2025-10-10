import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kheet_amal/core/utils/app_colors.dart';
import 'package:kheet_amal/core/utils/app_icons.dart';

Widget customSearchSuccess({required BuildContext context}) {
  return Column(
    children: [
      SizedBox(height: 30.h),
      Center(
        child: SvgPicture.asset(
          "assets/svgs/search_image.svg",
          height: 200.h,
          width: 200.w,
        ),
      ),
      SizedBox(height: 20.h),
      Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,

            children: [
              Expanded(
                child: Text(
                  "search_message".tr(),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: AppColors.black,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 64.h),
          Align(
            alignment: Alignment.topRight,
            child: Text(
              "latest_cases".tr(),
              style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          SizedBox(height: 16.h),
        ],
      ),
    ],
  );
}