import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../../core/utils/app_colors.dart';

class RegisterModel {
  final String username;
  final String password;
  final String nationalId;
  final String phone;

  RegisterModel({
    required this.username,
    required this.password,
    required this.nationalId,
    required this.phone,
  });
}

class CustomTextField extends StatelessWidget {
  final String hint;
  final bool isPassword;
  final TextEditingController controller;
  final Widget? prefixIcon;
  final String? Function(String?) validator;
  final String? errorText;

  const CustomTextField({
    super.key,
    required this.hint,
    required this.controller,
    this.isPassword = false,
    this.prefixIcon,
    required this.validator,
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(27.w, 6.h, 33.w, 0),
      child: SizedBox(
        width: 380.w,
        child: TextFormField(
          style: TextStyle(fontSize: 16.sp),
          controller: controller,
          obscureText: isPassword,
          decoration: InputDecoration(
            errorText: errorText,
            hintText: hint.tr(),
            hintStyle: TextStyle(color: AppColors.hintTextColor),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: AppColors.primaryColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: AppColors.primaryColor, width: 3.w),
            ),
            contentPadding: EdgeInsets.symmetric(
              vertical: 10.h,
              horizontal: 15.w,
            ),
            prefixIconConstraints: BoxConstraints(
              minWidth: 18.w,
              minHeight: 18.h,
            ),
            prefixIcon: Padding(
              padding: EdgeInsets.only(left: 8.w, right: 14.w),
              child: prefixIcon,
            ),
            fillColor: Colors.white,
            filled: true,
          ),
          validator: validator,
        ),
      ),
    );
  }
}
