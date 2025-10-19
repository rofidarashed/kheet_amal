import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';

class InfoBanner extends StatelessWidget {
  const InfoBanner({super.key, required this.selectedTabIndex});

  final int selectedTabIndex;

  @override
  Widget build(BuildContext context) {
    final bool isMissing = selectedTabIndex == 0;

    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: isMissing ? const Color(0xFFFADADA) : const Color(0xFFFFF1C9),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            isMissing ? Icons.warning_amber_rounded : Icons.error_outline,
            size: 26.sp,
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  isMissing
                      ? 'missingBannerTitle'.tr()
                      : 'suspectsBannerTitle'.tr(),
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 6.h),
                Text(
                  isMissing
                      ? 'missingBannerDesc'.tr()
                      : 'suspectsBannerDesc'.tr(),
                  style: TextStyle(
                    fontSize: 13.sp,
                    color: Colors.black87,
                    height: 1.3,
                  ),
                  textAlign: TextAlign.right,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
