import 'dart:ui' as ui;

import 'package:country_code_picker/country_code_picker.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kheet_amal/core/utils/app_colors.dart';
import 'package:kheet_amal/core/utils/my_validators.dart';
import 'package:kheet_amal/core/widgets/custom_form_field.dart';

class ContactField extends StatelessWidget {
  const ContactField({
    super.key,
    required this.onCahnged,
    required this.subtitle,
    required this.phoneController,
  });

  final TextEditingController phoneController;
  final ValueChanged<CountryCode> onCahnged;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: ui.TextDirection.ltr,
      child: CustomFormField(
        controller: phoneController,

        prefixIcon: Container(
          margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
          width: 63.w,
          height: 20.h,
          decoration: BoxDecoration(
            color: AppColors.primaryColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: CountryCodePicker(
              onChanged: onCahnged,
              initialSelection: '+20',
              favorite: ['+20', '+966', '+971'],
              showCountryOnly: false,
              showFlag: false,
              showOnlyCountryWhenClosed: false,
              alignLeft: false,
              textStyle: TextStyle(
                color: AppColors.backgroundColor,
                fontSize: 12.sp,
                fontWeight: FontWeight.w700,
              ),

              padding: EdgeInsets.all(0),
            ),
          ),
        ),

        validator: (value) => AppValidators.phoneValidator(value, context),
        title: 'add_report.contact_number'.tr(),
        subtitle: subtitle,
        hint: 'add_report.enter_phone_number'.tr(),
      ),
    );
  }
}
