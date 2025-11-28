import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kheet_amal/core/utils/app_colors.dart';

class CustomTextEditField extends StatelessWidget {
  const CustomTextEditField({
    super.key,
    required this.label,
    required this.controller,
    this.validator,
    this.readOnly = false,
    this.fillColor,
  });

  final String label;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final bool readOnly;
  final Color? fillColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          label,
          textAlign: TextAlign.right,
          style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 24.sp,
          ),
        ),
        SizedBox(height: 5.h),
        SizedBox(
          width: 390.w,
          height: 45.h,
          child: TextFormField(
            controller: controller,
            textAlign: TextAlign.right,
            validator: validator,
            readOnly: readOnly,
            decoration: InputDecoration(
              filled: fillColor != null,
              fillColor: fillColor ?? AppColors.backgroundColor,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.r),
                borderSide: const BorderSide(color: AppColors.primaryColor),
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: 10.w,
                vertical: 10.h,
              ),
            ),
            style: TextStyle(fontSize: 16.sp),
          ),
        ),
        SizedBox(height: 15.h),
      ],
    );
  }
}
