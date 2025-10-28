import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kheet_amal/core/routing/app_routes.dart';
import 'package:kheet_amal/core/utils/app_validators.dart';
import 'package:kheet_amal/feature/auth/cubit/auth_cubit.dart';
import 'package:kheet_amal/feature/auth/cubit/auth_state.dart';

import '../widgets/custom_check_box.dart';
import '../widgets/custom_field_label.dart';
import '../widgets/custom_register_button.dart';
import '../widgets/custom_text_button.dart';
import '../widgets/custom_text_field.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: Scaffold(
        body: BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            if (state is AuthLoading) {
              return Center(child: CircularProgressIndicator());
            }

            if (state is AuthSuccess) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Navigator.pushReplacementNamed(context, AppRoutes.homeLayout);
              });
            }
            String? emailError;
            String? passwordError;
            String? phoneError;
            String? nameError;

            if (state is AuthFailure) {
              if (state.error.contains('email')) {
                emailError = state.error;
              } else if (state.error.contains('password')) {
                passwordError = state.error;
              } else if (state.error.contains('phone')) {
                phoneError = state.error;
              } else if (state.error.contains('name')) {
                nameError = state.error;
              } else {
                debugPrint(state.error);
              }
            }

            return Form(
              key: _formKey,
              child: SafeArea(
                child: Column(
                  children: [
                    Image.asset(
                      "assets/images/logo.png",
                      height: 180.h,
                      width: 180.w,
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 22.w, 0),
                      child: Align(
                        alignment: Alignment.topRight,
                        child: Text(
                          "create_new_account".tr(),
                          style: TextStyle(
                            fontSize: 32.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                    FieldLabel("username".tr()),
                    CustomTextField(
                      validator: (_) => AppValidators.displayNamevalidator(
                        usernameController.text,
                      ),
                      hint: "enter_username".tr(),
                      controller: usernameController,
                      errorText: nameError,
                      suffixIcon: Padding(
                        padding: EdgeInsets.all(7.w),
                        child: Image.asset(
                          "assets/images/user-circle.png",
                          height: 24.h,
                          width: 24.w,
                        ),
                      ),
                    ),
                    FieldLabel("national_id".tr()),
                    CustomTextField(
                      validator: (p0) => AppValidators.nationalIdValidator(
                        emailController.text,
                      ),
                      hint: "enter_national_id".tr(),
                      controller: emailController,
                      errorText: emailError,
                      suffixIcon: Padding(
                        padding: EdgeInsets.all(7.w),
                        child: Image.asset(
                          "assets/images/identification-card.png",
                          height: 24.h,
                          width: 24.w,
                        ),
                      ),
                    ),
                    FieldLabel("mobile_number".tr()),
                    CustomTextField(
                      validator: (p0) => AppValidators.phoneValidator(
                        phoneController.text,
                        context,
                      ),
                      hint: "enter_mobile_number".tr(),
                      controller: phoneController,
                      errorText: phoneError,
                      suffixIcon: Padding(
                        padding: EdgeInsets.all(9.w),
                        child: Image.asset(
                          "assets/images/phone_sign.png",
                          height: 24.h,
                          width: 24.w,
                        ),
                      ),
                    ),
                    FieldLabel("password".tr()),
                    CustomTextField(
                      validator: (p0) => AppValidators.passwordValidator(
                        passwordController.text,
                      ),
                      hint: "enter_password".tr(),
                      controller: passwordController,
                      errorText: passwordError,
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
                    TermsAgreement(),
                    RegisterButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          final cubit = context.read<AuthCubit>();
                          cubit.registerUser(
                            email: emailController.text.trim(),
                            password: passwordController.text.trim(),
                            name: usernameController.text.trim(),
                            phone: phoneController.text.trim(),
                          );
                        }
                      },
                      textButton: 'register'.tr(),
                    ),
                    AlreadyHaveAccount(
                      actionText: "login".tr(),
                      questionText: "already_have_account".tr(),
                      onTap: () {
                        Navigator.pushNamed(context, AppRoutes.login);
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
