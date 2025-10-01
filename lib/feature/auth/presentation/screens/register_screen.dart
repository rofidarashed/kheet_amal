import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kheet_amal/core/routing/app_routes.dart';
import 'package:kheet_amal/core/utils/my_validators.dart';

import '../widgets/custom_check_box.dart';
import '../widgets/custom_field_label.dart';
import '../widgets/custom_register_button.dart';
import '../widgets/custom_text_button.dart';
import '../widgets/custom_text_field.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});
  final usernameController = TextEditingController();
  final nationalIdController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: SafeArea(
          child: Column(
            children: [
              Image.asset("assets/images/logo.png", height: 180.h, width: 180.w),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 22.w, 0),
                child: Align(
                  alignment: Alignment.topRight,
                  child: Text(
                    "create_new_account".tr(),
                    style: TextStyle(fontSize: 32.sp, fontWeight: FontWeight.w400),
                  ),
                ),
              ),
              FieldLabel("username".tr()),
              CustomTextField(
                validator: (_) => MyValidators.displayNamevalidator(usernameController.text),
                hint: "enter_username".tr(),
                controller: usernameController,
                suffixIcon: Padding(
                  padding: EdgeInsets.all(7.w),
                  child: Image.asset("assets/images/user-circle.png", height: 24.h, width: 24.w),
                ),
              ),
              FieldLabel("national_id".tr()),
              CustomTextField(
                validator: (p0) => MyValidators.nationalIdValidator(nationalIdController.text),
                hint: "enter_national_id".tr(),
                controller: nationalIdController,
                suffixIcon: Padding(
                  padding: EdgeInsets.all(7.w),
                  child: Image.asset("assets/images/identification-card.png", height: 24.h, width: 24.w),
                ),
              ),
              FieldLabel("mobile_number".tr()),
              CustomTextField(
                validator: (p0) => MyValidators.phoneValidator(phoneController.text, context),
                hint: "enter_mobile_number".tr(),
                controller: phoneController,
                suffixIcon: Padding(
                  padding: EdgeInsets.all(9.w),
                  child: Image.asset("assets/images/phone_sign.png", height: 24.h, width: 24.w),
                ),
              ),
              FieldLabel("password".tr()),
              CustomTextField(
                validator: (p0) => MyValidators.passwordValidator(passwordController.text),
                hint: "enter_password".tr(),
                controller: passwordController,
                isPassword: true,
                suffixIcon: Padding(
                  padding: EdgeInsets.all(10.w),
                  child: Image.asset("assets/images/pass_sign.png", height: 24.h, width: 24.w),
                ),
              ),
              TermsAgreement(),
              RegisterButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final model = RegisterModel(
                      username: usernameController.text,
                      nationalId: nationalIdController.text,
                      phone: phoneController.text,
                      password: passwordController.text,
                    );
                    print(model.username);
                    Navigator.pushNamed(context, AppRoutes.homeLayout);
                  }
                },
                textButton: 'register'.tr(),
              ),
              AlreadyHaveAccount(
                actionText: "login".tr(),
                questionText: "already_have_account".tr(),
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    AppRoutes.login,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}