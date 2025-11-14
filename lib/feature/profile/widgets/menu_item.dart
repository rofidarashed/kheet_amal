import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';

class MenuItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final int? count;
  final Color? iconColor;
  final Color? textColor;
  final VoidCallback? onTap;


  const MenuItem({
    super.key,
    required this.title,
    required this.icon,
    this.count,
    this.iconColor,
    this.textColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: [
            Icon(
              Icons.chevron_left,
              size: 22.sp,
              color: title == 'logout'.tr() ? Colors.red : Colors.black,
            ),
            const Spacer(),
            if (count != null)
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                decoration: BoxDecoration(
                  color: Colors.orange.shade200,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text('$count', style: TextStyle(fontSize: 22.sp)),
              ),
            SizedBox(width: 10.w),
            Text(
              title.tr(),
              style: TextStyle(fontSize: 22.sp, color: textColor ?? Colors.black),
            ),
            SizedBox(width: 10.w),
            Icon(icon, size: 22.sp, color: iconColor),
          ],
        ),
      ),
    );
  }
}
