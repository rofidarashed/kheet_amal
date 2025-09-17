import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/utils/app_colors.dart';

class CustomPasswordField extends StatelessWidget {
  final String label;
  final String hint;
  final TextEditingController controller;
  final bool isPasswordVisible;
  final VoidCallback toggleVisibility;
  final String? Function(String?)? validator;

  const CustomPasswordField({
    Key? key,
    required this.label,
    required this.hint,
    required this.controller,
    required this.isPasswordVisible,
    required this.toggleVisibility,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
        SizedBox(height: 8),
        TextFormField(
          onTapOutside: ((event) {
            FocusScope.of(context).unfocus();
          }),
          controller: controller,
          obscureText: !isPasswordVisible,
          textDirection: TextDirection.ltr,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: Colors.grey[400], fontSize: 14),
            suffixIcon: IconButton(
              icon: Icon(
                isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                color: Colors.grey[600],
              ),
              onPressed: toggleVisibility,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: AppColors.primaryColor, width: 4),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: AppColors.secondaryColor,
                width: 1.6.w,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: AppColors.primaryColor,
                width: 1.6.w,
              ),
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          ),
          validator: validator,
        ),
      ],
    );
  }
}
