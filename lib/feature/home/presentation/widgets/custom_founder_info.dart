import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kheet_amal/core/utils/app_colors.dart';
import 'package:kheet_amal/feature/home/presentation/widgets/custom_icon_button.dart';

class FounderInfo extends StatelessWidget {
  const FounderInfo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
      ],
    );
  }
}
