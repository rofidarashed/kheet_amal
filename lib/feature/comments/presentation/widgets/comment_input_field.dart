import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:kheet_amal/core/utils/app_colors.dart';

class CommentInputField extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSend;

  const CommentInputField({
    super.key,
    required this.controller,
    required this.onSend,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        child: Row(
          children: [
            CircleAvatar(
              radius: 22.r,
              backgroundColor: AppColors.secondaryColor,
              child: IconButton(
                icon: Icon(Icons.arrow_back, color: AppColors.white, size: 24.sp),
                onPressed: onSend, // أو أي وظيفة ترجع للقائمة
              ),
            ),
            SizedBox(width: 8.w),
            Expanded(
              child: TextField(
                controller: controller,
                textAlign: TextAlign.right,
                decoration: InputDecoration(
                  hintText: 'write_comment'.tr(),
                  hintStyle: TextStyle(fontSize: 18.sp),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.r),
                    borderSide: BorderSide(color: AppColors.inactiveTrackbarColor),
                  ),
                  contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
