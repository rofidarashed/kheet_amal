import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kheet_amal/core/routing/app_routes.dart';
import 'package:kheet_amal/core/utils/app_icons.dart';
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
  final _checkboxKey = GlobalKey<FormFieldState<bool>>();

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

            if (state is AuthFailure) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                String message = "";

                switch (state.error) {
                  case "email-verification-sent":
                    message = "verification_email_sent".tr();
                    break;

                  case "email-not-verified":
                    message = "please_confirm_email".tr();
                    break;
                  case "email-already-in-use":
                    message = "email_already_exists".tr();
                    break;

                  case "invalid-email":
                    message = "invalid_email_format".tr();
                    break;

                  default:
                    message = "something_went_wrong".tr();
                }
                log('Auth Error: ${state.error} message: $message');
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(message), backgroundColor: Colors.red),
                );
              });
            }

            return Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: SafeArea(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
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
                        prefixIcon: SvgPicture.asset(AppIcons.userIcon),
                      ),
                      FieldLabel("email".tr()),
                      CustomTextField(
                        validator: (p0) =>
                            AppValidators.emailValidator(emailController.text),
                        hint: "enter_email".tr(),
                        controller: emailController,
                        prefixIcon: SvgPicture.asset(AppIcons.emailIcon),
                      ),
                      FieldLabel("mobile_number".tr()),
                      CustomTextField(
                        validator: (p0) => AppValidators.phoneValidator(
                          phoneController.text,
                          context,
                        ),
                        hint: "enter_mobile_number".tr(),
                        controller: phoneController,
                        prefixIcon: SvgPicture.asset(AppIcons.phoneIcon),
                      ),
                      FieldLabel("password".tr()),
                      CustomTextField(
                        validator: (p0) => AppValidators.passwordValidator(
                          passwordController.text,
                        ),
                        hint: "enter_password".tr(),
                        controller: passwordController,
                        isPassword: true,
                        prefixIcon: SvgPicture.asset(AppIcons.lockIcon),
                      ),
                      TermsAgreement(
                        value: context.watch<AuthCubit>().value,
                        onChanged: (bool? newValue) {
                          context.read<AuthCubit>().toggleValue();
                          _checkboxKey.currentState?.validate();
                        },
                        checkboxValidator: (val) =>
                            AppValidators.checkboxValidator(val),
                      ),

                      RegisterButton(
                        onPressed: () {
                          final isFormValid =
                              _formKey.currentState?.validate() ?? false;
                          final isCheckboxChecked = context
                              .read<AuthCubit>()
                              .value;
                          if (isFormValid && isCheckboxChecked) {
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
                      CustomTextButton(
                        actionText: "login".tr(),
                        questionText: "already_have_account".tr(),
                        onTap: () {
                          Navigator.pushNamed(context, AppRoutes.login);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
