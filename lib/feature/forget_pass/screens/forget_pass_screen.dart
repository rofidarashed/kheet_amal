import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:kheet_amal/core/utils/app_colors.dart';
import 'package:country_code_picker/country_code_picker.dart';
import '../../../core/routing/app_routes.dart';
import '../widgets/custom_appbar.dart';
import '../widgets/custom_button.dart';
import 'dart:ui' as ui;

class ForgetPassScreen extends StatefulWidget {
  const ForgetPassScreen({super.key});

  @override
  State<ForgetPassScreen> createState() => _ForgetPassScreenState();
}

class _ForgetPassScreenState extends State<ForgetPassScreen> {
  final TextEditingController _phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  String _selectedCode = "+20";

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gap(25.h),
              Text(
                'forgot_password'.tr(),
                style: TextStyle(
                  fontSize: 30.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              Gap(20.h),
              Text(
                'enter_phone_number_msg'.tr(),
                style: TextStyle(
                  fontSize: 20.sp,
                  color: Colors.grey[700],
                  height: 1.2,
                ),
                textAlign: TextAlign.center,
              ),
              Gap(60.h),
              Text(
                'phone_number'.tr(),
                style: TextStyle(
                  fontSize: 17.sp,
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Gap(5.h),
              Directionality(
                textDirection: ui.TextDirection.ltr,
                child: TextFormField(
                  onTapOutside: ((event) {
                    FocusScope.of(context).unfocus();
                  }),
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                      borderSide: BorderSide(color: AppColors.primaryColor),
                    ),
                    hint: Row(
                      children: [
                        Text(
                          'enter_phone_number'.tr(),
                          style: TextStyle(
                            color: Colors.grey[900],
                            fontSize: 14.sp,
                          ),
                        ),
                        Gap(8.w),
                        Icon(
                          Icons.phone_outlined,
                          color: Colors.grey[600],
                          size: 18.sp,
                        ),
                      ],
                    ),
                    prefixIcon: Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: 10.w,
                        vertical: 10.h,
                      ),
                      width: 100.w,
                      height: 20.h,
                      decoration: BoxDecoration(
                        color: AppColors.secondaryColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: CountryCodePicker(
                          onChanged: (code) {
                            setState(() {
                              _selectedCode = code.dialCode!;
                            });
                          },
                          initialSelection: '+20',
                          favorite: ['+20', '+966', '+971'],
                          showCountryOnly: false,
                          showOnlyCountryWhenClosed: false,
                          alignLeft: false,
                          textStyle: TextStyle(
                            color: AppColors.backgroundColor,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w500,
                          ),
                          padding: EdgeInsets.zero,
                        ),
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                      borderSide: BorderSide(color: AppColors.primaryColor),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                      borderSide: const BorderSide(
                        color: AppColors.secondaryColor,
                        width: 2,
                      ),
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 14.h,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Phone number is required';
                    } else if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
                      return 'Enter valid phone number';
                    }
                    return null;
                  },
                ),
              ),
              Gap(40.h),
              Center(
                child: CustomButton(
                  text: 'send_code'.tr(),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      final fullNumber =
                          "$_selectedCode${_phoneController.text}";

                      Navigator.of(context).pushNamed(AppRoutes.verification);
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
