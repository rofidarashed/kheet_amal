import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kheet_amal/core/utils/app_colors.dart';

class StatsSection extends StatelessWidget {
  const StatsSection({super.key, required this.title, required this.value});

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 8.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: TextStyle(fontSize: 20.sp)),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
              decoration: BoxDecoration(
                color: AppColors.sLightPrimary,
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Text(value, style: TextStyle(fontSize: 16.sp)),
            ),
          ],
        ),
      ],
    );
  }
}
