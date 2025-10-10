import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kheet_amal/core/utils/app_colors.dart';
import 'package:kheet_amal/core/utils/app_icons.dart';

Widget customSearchRow({required BuildContext context}) {
  return Row(
    children: [
      SizedBox(
        width: 325.w,
        height: 37.h,
        child: TextFormField(
          onTapOutside: (event) => FocusScope.of(context).unfocus(),
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50.r),
              borderSide: BorderSide(color: AppColors.primaryColor),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50.r),
              borderSide: BorderSide(color: AppColors.primaryColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50.r),
              borderSide: BorderSide(
                color: AppColors.primaryColor,
                width: 2,
              ),
            ),
            prefixIcon: IconButton(
              icon: Icon(Icons.cancel_outlined, size: 21.sp),
              onPressed: () {
                FocusScope.of(context).unfocus();
              },
              color: AppColors.primaryColor,
            ),
            suffixIcon: IconButton(
              padding: EdgeInsets.only(right: 22.w),
              onPressed: () {},
              icon: SvgPicture.asset(
                AppIcons.searchIcon,
                height: 20.h,
                width: 20.w,
              ),
            ),
            hintText: 'search_placeholder'.tr(),
            hintStyle: TextStyle(
              color: AppColors.hintTextColor,
              fontSize: 15.sp,
            ),
          ),
        ),
      ),
      SizedBox(width: 8.w),
      GestureDetector(
        child: Container(
          height: 37.h,
          width: 55.w,
          decoration: BoxDecoration(
            color: AppColors.secondaryColor,
            borderRadius: BorderRadius.circular(13.r),
          ),
          child: Icon(Icons.tune_rounded, color: AppColors.white),
        ),
      ),
    ],
  );
}