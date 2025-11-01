import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
            fontWeight: FontWeight.bold,
            fontSize: 24.sp,
          ),
        ),
        SizedBox(height: 5.h),
        TextFormField(
          controller: controller,
          textAlign: TextAlign.right,
          validator: validator,
          readOnly: readOnly,
          decoration: InputDecoration(
            filled: fillColor != null,
            fillColor: fillColor ?? Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: const BorderSide(color: Colors.blue),
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: 12.w,
              vertical: 14.h,
            ),
          ),
          style: TextStyle(fontSize: 18.sp),
        ),
        SizedBox(height: 15.h),
      ],
    );
  }
}
