import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kheet_amal/core/utils/app_colors.dart';
import 'package:kheet_amal/feature/home/widgets/info_row.dart';

class DisappearanceDetailsCard extends StatelessWidget {
  const DisappearanceDetailsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
            Divider(
              color: AppColors.primaryColor,
              thickness: 1.h,
              height: 0,
              indent: 55.w,
              endIndent: 55.w,
            ),
            InfoRow(
              label: 'clothing_at_disappearance'.tr(),
              value:
                  'نينةرنمةسمنبنةنرنمرةنرةرةرةرةرنررنمرمرمرولاولامملاملاملانلانلاةلاةلاةلاىلاىلالاى',
            ),
          ],
        ),
      ),
    );
  }
}