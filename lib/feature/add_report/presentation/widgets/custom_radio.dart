import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kheet_amal/core/utils/app_colors.dart';

class CustomRadio extends StatelessWidget {
  final bool selected;
  final String label;
  final VoidCallback onTap;

  const CustomRadio({
    super.key,
    required this.selected,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.only(top: 8.0.h),
        child: Row(
          children: [
            Container(
              height: 24.h,
              width: 24.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.primaryColor, width: 1.3),
              ),
              child: selected
                  ? Center(
                      child: Container(
                        height: 18.h,
                        width: 18.w,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    )
                  : null,
            ),
            SizedBox(width: 8.w),
            Text(label),
          ],
        ),
      ),
    );
  }
}
