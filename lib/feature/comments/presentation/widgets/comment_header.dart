import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:kheet_amal/core/utils/app_colors.dart';

import '../../data/models/comment_model.dart';


class CommentHeader extends StatelessWidget {
  final Comment comment;
  final VoidCallback onReport;

  const CommentHeader({
    super.key,
    required this.comment,
    required this.onReport,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        PopupMenuButton<int>(
          icon: Icon(Icons.more_vert, size: 22.sp),
          itemBuilder: (ctx) => [
            PopupMenuItem(
              value: 1,
              child: Text(
                'report'.tr(),
                style: TextStyle(fontSize: 18.sp),
              ),
            ),
          ],
          onSelected: (value) {
            if (value == 1) onReport();
          },
        ),
        Row(
          children: [
            Text(
              comment.time,
              style: TextStyle(
                color: AppColors.inactiveTrackbarColor,
                fontSize: 16.sp,
              ),
            ),
            SizedBox(width: 8.w),
            Text(
              comment.name,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.sp,
              ),
            ),
            SizedBox(width: 8.w),
            CircleAvatar(
              radius: 22.r,
              child: Icon(
                Icons.person,
                color: AppColors.white,
                size: 26.sp,
              ),
            ),
          ],
        ),
      ],
    );
  }
}