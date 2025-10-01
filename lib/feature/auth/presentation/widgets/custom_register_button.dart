import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../core/utils/app_colors.dart';

class RegisterButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String textButton;

  RegisterButton({
    required this.onPressed,
    required this.textButton,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.secondaryColor,
          minimumSize: Size(307.w, 45.h),
        ),
        child: Text(
          textButton.tr(),
          style: TextStyle(fontSize: 24.sp, color: Colors.white),
        ),
      ),
    );
  }
}