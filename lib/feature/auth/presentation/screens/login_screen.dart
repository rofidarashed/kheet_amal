import 'package:flutter/material.dart';
import 'package:kheet_amal/core/routing/app_routes.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kheet_amal/core/utils/app_validators.dart';
import '../../../../core/utils/app_colors.dart';
import '../widgets/custom_field_label.dart';
import '../widgets/custom_register_button.dart';
import '../widgets/custom_text_button.dart';
import '../widgets/custom_text_field.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final usernameController = TextEditingController();
    final passwordController = TextEditingController();
    final _formKey = GlobalKey<FormState>();

    return Scaffold(
      body: Form(
        key: _formKey,
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Image.asset(
                  "assets/images/logo.png",
                  height: 180.h,
                  width: 180.w,
                ),
              ),
              SizedBox(height: 10.h),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 23.w, 0),
                child: Align(
                  alignment: Alignment.topRight,
                  child: Text(
                    "login".tr(),
                    style: TextStyle(
                      fontSize: 32.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              FieldLabel("username".tr()),
              CustomTextField(
                validator: (p0) =>
                    AppValidators.displayNamevalidator(usernameController.text),
                hint: "enter_username".tr(),
                controller: usernameController,
                suffixIcon: Padding(
                  padding: EdgeInsets.all(7.w),
                  child: Image.asset(
                    "assets/images/user-circle.png",
                    height: 24.h,
                    width: 24.w,
                  ),
                ),
              ),
              FieldLabel("password".tr()),
              CustomTextField(
                validator: (p0) =>
                    AppValidators.passwordValidator(passwordController.text),
                hint: "enter_password".tr(),
                controller: passwordController,
                isPassword: true,
                suffixIcon: Padding(
                  padding: EdgeInsets.all(10.w),
                  child: Image.asset(
                    "assets/images/pass_sign.png",
                    height: 24.h,
                    width: 24.w,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.w),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, AppRoutes.forgetPass);
                    },
                    child: Text(
                      "forgot_password".tr(),
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColors.secondaryColor,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 40.h),
              RegisterButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Navigator.pushNamed(context, AppRoutes.homeLayout);
                  }
                },
                textButton: "login".tr(),
              ),
              AlreadyHaveAccount(
                actionText: "create_new_account".tr(),
                questionText: "dont_have_account".tr(),
                onTap: () {
                  Navigator.pushNamed(context, AppRoutes.register);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}