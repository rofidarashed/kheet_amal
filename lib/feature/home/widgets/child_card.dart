import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:kheet_amal/feature/report_details/screen/report_details.dart';
import 'info_row.dart';

class ChildCard extends StatelessWidget {
  const ChildCard({super.key, required this.theme});

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ReportDetails()),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
        ),
        padding: EdgeInsets.all(10.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10.r),
                      child: Image.asset(
                        'assets/images/boy.png',
                        width: 120.w,
                        height: 150.h,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      top: 4.h,
                      left: 4.w,
                      child: CircleAvatar(
                        radius: 14.r,
                        backgroundColor: Colors.white70,
                        child: Icon(
                          Icons.bookmark_border,
                          color: Colors.black87,
                          size: 16.sp,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SizedBox(height: 2.h),
                      InfoRow(label: 'name'.tr(), value: 'احمد محمد'),
                      SizedBox(height: 6.h),
                      InfoRow(label: 'age'.tr(), value: '7'),
                      SizedBox(height: 6.h),
                      InfoRow(label: 'place'.tr(), value: 'مصر الجديدة'),
                      SizedBox(height: 6.h),
                      Text(
                        'since'.tr(),
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 13.sp,
                        ),
                        textAlign: TextAlign.right,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.h),
            Row(
              children: [
                Text('20', style: TextStyle(fontSize: 12.sp)),
                SizedBox(width: 3.w),
                Icon(Icons.chat_bubble_outline, size: 16.sp),
                SizedBox(width: 12.w),
                Text('20', style: TextStyle(fontSize: 12.sp)),
                SizedBox(width: 3.w),
                Icon(Icons.favorite_border, size: 16.sp),
                const Spacer(),
                SizedBox(
                  width: 180.w,
                  height: 36.h,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFF19A3E),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                    ),
                    onPressed: () {},
                    child: Text(
                      'details'.tr(),
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
