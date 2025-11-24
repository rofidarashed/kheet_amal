import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kheet_amal/core/utils/app_colors.dart';

class CustomIconButton extends StatelessWidget {
  final String text;
  final Color backgroundColor;
  final VoidCallback onPressed;
  final double borderRadius;
  final TextStyle? textStyle;
  final Widget? icon;

  const CustomIconButton({
    super.key,
    required this.text,
    required this.backgroundColor,
    required this.onPressed,
    this.borderRadius = 30.0,
    this.textStyle,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 180.w,
      height: 35.h,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero,
          backgroundColor: backgroundColor,
          alignment: Alignment.center,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[icon!, SizedBox(width: 8.w)],
            Text(
              text,
              style:
                  textStyle ??
                  TextStyle(
                    fontSize: 22.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.backgroundColor,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
