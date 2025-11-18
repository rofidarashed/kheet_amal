import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kheet_amal/core/utils/app_colors.dart';
import 'package:easy_localization/easy_localization.dart';

class AppBarComment extends StatelessWidget implements PreferredSizeWidget {
  const AppBarComment({super.key, required this.countOfComment});
final String countOfComment ;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      leading: IconButton(
        icon: Icon(Icons.close, color: AppColors.black, size: 26.sp),
        onPressed: () => Navigator.of(context).pop(),
      ),
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: AppColors.secondaryColor.withOpacity(0.2),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Text(
              countOfComment,
              style: TextStyle(color: AppColors.black, fontSize: 18.sp),
            ),
          ),
          SizedBox(width: 8.w),
          Text(
            'comments'.tr(),
            style: TextStyle(color: AppColors.black, fontSize: 24.sp),
          ),
        ],
      ),
      centerTitle: true,
    );
  }


  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
