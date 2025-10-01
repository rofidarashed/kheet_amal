import 'package:flutter/cupertino.dart';
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
  final Widget? suffixIcon;
  final String? Function(String?) validator ;

  CustomTextField({
    super.key,
    required this.hint,
    required this.controller,
    this.isPassword = false,
    this.suffixIcon, required this.validator,

  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(27.w, 6.h, 33.w, 0),
      child: SizedBox(
        width: 380.w,
        height: 45.h,
        child: TextFormField(
          controller: controller,
          obscureText: isPassword,
          decoration: InputDecoration(
            hintText: hint.tr(),
            hintStyle: TextStyle(color: AppColors.hintTextColor),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: AppColors.primaryColor),
            ),
            suffixIcon: suffixIcon,
          ),
          validator: validator ,
        ),
      ),
    );
  }
}