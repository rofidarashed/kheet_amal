import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kheet_amal/core/routing/app_routes.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kheet_amal/core/utils/app_icons.dart';
import 'package:kheet_amal/core/utils/app_validators.dart';
import 'package:kheet_amal/feature/auth/cubit/auth_cubit.dart';
import 'package:kheet_amal/feature/auth/cubit/auth_state.dart';
import '../../../../core/utils/app_colors.dart';
import '../widgets/custom_field_label.dart';
import '../widgets/custom_register_button.dart';
import '../widgets/custom_text_button.dart';
import '../widgets/custom_text_field.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final _formKey = GlobalKey<FormState>();

    return BlocProvider(
      create: (context) => AuthCubit(),
      child: Scaffold(
        body: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is AuthSuccess) {
              Navigator.pushReplacementNamed(context, AppRoutes.homeLayout);
            }
          },

          builder: (context, state) {
            if (state is AuthFailure) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                String message = state.error;
                print(state.error);
                if (state.error.contains('email-not-verified')) {
                  message = 'please_confirm_email'.tr();
                } else if (state.error.contains('user-not-found') ||
                    state.error.contains('wrong-password') ||
                    state.error.contains('invalid-email') ||
                    state.error.contains('invalid-credential')) {
                  message = "wrong_email_or_password".tr();
                }

                log('Auth Error: ${state.error} message: $message');

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(message),
                    backgroundColor: AppColors.red,
                  ),
                );
              });
            }

            if (state is AuthSuccess) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Navigator.pushReplacementNamed(context, AppRoutes.homeLayout);
              });
            }

            if (state is AuthLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            return SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: SafeArea(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
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
                        padding: EdgeInsets.fromLTRB(23.w, 0, 23.w, 0),
                        child: Align(
                          alignment: context.locale.languageCode == 'ar'
                              ? Alignment.topRight
                              : Alignment.topLeft,
                          child: Text(
                            "login".tr(),
                            style: TextStyle(
                              fontSize: 32.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                      FieldLabel("email".tr()),
                      CustomTextField(
                        validator: (p0) =>
                            AppValidators.emailValidator(emailController.text),
                        hint: "enter_email".tr(),
                        controller: emailController,
                        prefixIcon: SvgPicture.asset(AppIcons.emailIcon),
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
                      Padding(
                        padding: EdgeInsets.all(8.w),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: TextButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                context,
                                AppRoutes.forgetPass,
                              );
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
                            context.read<AuthCubit>().loginUser(
                              email: emailController.text.trim(),
                              password: passwordController.text.trim(),
                            );
                          }
                        },
                        textButton: "login".tr(),
                      ),
                      CustomTextButton(
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
          },
        ),
      ),
    );
  }
}
