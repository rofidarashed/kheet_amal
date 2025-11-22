import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:kheet_amal/core/utils/app_colors.dart';

class ReplyInputField extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSubmit;

  const ReplyInputField({
    super.key,
    required this.controller,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 40.w, bottom: 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: AppColors.inactiveTrackbarColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: TextField(
              controller: controller,
              textAlign: TextAlign.right,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              decoration: InputDecoration(
                hintText: 'write_reply_here'.tr(),
                border: InputBorder.none,
                hintStyle: TextStyle(
                  color: AppColors.inactiveTrackbarColor,
                  fontSize: 16.sp,
                ),
              ),
              style: TextStyle(fontSize: 18.sp),
            ),
          ),
          SizedBox(height: 6.h),
          Align(
            alignment: Alignment.centerLeft,
            child: ElevatedButton(
              onPressed: onSubmit,
              child: const Text("إرسال"),
            ),
          ),
        ],
      ),
    );
  }
}