import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kheet_amal/core/utils/app_images.dart';

import '../../../core/utils/app_colors.dart';

class EmptyArchives extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(
      child: Padding(
        padding: EdgeInsets.only(top: 100.h),
        child: Column(
          children: [
            Image.asset(AppImages.emptyReport),
            SizedBox(height: 15.h,),
            Text("No Saved items yet".tr(),style: TextStyle(color: AppColors.black,fontSize: 24.sp),),
            SizedBox(height: 25.h,),
            TextButton(
              onPressed: (){},
              style: TextButton.styleFrom(
                backgroundColor: AppColors.secondaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40.r),
                ),
                padding: EdgeInsets.symmetric(horizontal: 12.h, vertical: 8.w),
                fixedSize: Size(160.w, 32.h),
              ),
              child: Text("Main".tr(), style: TextStyle(color: AppColors.white,fontSize: 16.sp),),),
          ],
        ),
      ),
    );
  }

}