import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kheet_amal/core/utils/app_colors.dart';
import 'package:kheet_amal/core/utils/app_icons.dart';

class CustomDropdown<T> extends StatelessWidget {
  const CustomDropdown({
    super.key,
    required this.options,
    required this.hint,
    required this.onChanged,
    required this.title,
  });

  final Map<T, String> options;
  final ValueChanged<T?> onChanged;
  final String hint;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: context.locale.languageCode == 'ar'
          ? CrossAxisAlignment.start
          : CrossAxisAlignment.end,
      children: [
        SizedBox(height: 12.h),
        Text(title, style: TextStyle(fontSize: 20.sp)),
        SizedBox(height: 8.h),
        SizedBox(
          height: 45.h,
          child: DropdownButtonFormField2<T>(
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 0),
              filled: true,
              fillColor: AppColors.white,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.r),
                borderSide: BorderSide(
                  color: AppColors.primaryColor,
                  width: 1.w,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(
                  color: AppColors.primaryColor,
                  width: 2.w,
                ),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.r),
                borderSide: BorderSide(
                  color: AppColors.primaryColor,
                  width: 1.w,
                ),
              ),
            ),
            hint: Text(
              hint,
              style: const TextStyle(color: AppColors.hintTextColor),
            ),
            style: TextStyle(color: AppColors.black, fontSize: 18.sp),
            items: options.entries.map((entry) {
              return DropdownMenuItem<T>(
                alignment: context.locale.languageCode == 'ar'
                    ? AlignmentDirectional.centerEnd
                    : AlignmentDirectional.centerStart,
                value: entry.key,
                child: Text(entry.value),
              );
            }).toList(),
            onChanged: onChanged,
            menuItemStyleData: MenuItemStyleData(
              selectedMenuItemBuilder: (context, child) => Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
                decoration: BoxDecoration(
                  color: AppColors.primaryColor.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: child,
              ),
            ),
            dropdownStyleData: DropdownStyleData(
              elevation: 0,
              offset: Offset(0, -8.h),
              maxHeight: 200,
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: AppColors.primaryColor.withOpacity(0.3),
                  width: 1.w,
                ),
              ),
              scrollbarTheme: ScrollbarThemeData(
                thumbVisibility: MaterialStateProperty.all(false),
                thickness: MaterialStateProperty.all(0),
              ),
            ),
            iconStyleData: IconStyleData(
              icon: Padding(
                padding: EdgeInsetsGeometry.only(left: 23.w),
                child: SvgPicture.asset(AppIcons.drpoDownIcon),
              ),
            ),
            validator: (value) => value == null ? 'required'.tr() : null,
          ),
        ),
      ],
    );
  }
}