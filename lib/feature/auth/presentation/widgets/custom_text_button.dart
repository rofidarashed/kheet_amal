import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../core/utils/app_colors.dart';

class AlreadyHaveAccount extends StatelessWidget {
  final String actionText;
  final String questionText;
  final VoidCallback onTap;

  const AlreadyHaveAccount({
    super.key,
    required this.actionText,
    required this.questionText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: onTap,
            child: Text(
              actionText.tr(),
              style: TextStyle(
                fontSize: 21.sp,
                fontWeight: FontWeight.w400,
                color: AppColors.secondaryColor,
              ),
            ),
          ),
          SizedBox(width: 8.w),
          Text(
            questionText.tr(),
            style: TextStyle(
              fontSize: 21.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}