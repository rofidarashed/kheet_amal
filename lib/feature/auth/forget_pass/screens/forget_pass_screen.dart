import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:kheet_amal/core/utils/app_colors.dart';
import 'package:kheet_amal/core/utils/app_icons.dart';
import 'package:kheet_amal/core/utils/app_validators.dart';
import 'package:kheet_amal/feature/auth/cubit/auth_cubit.dart';
import 'package:kheet_amal/feature/auth/cubit/auth_state.dart';
import 'package:kheet_amal/feature/auth/presentation/widgets/custom_text_field.dart';
import '../widgets/custom_appbar.dart';
import '../../../../core/widgets/custom_button.dart';

class ForgetPassScreen extends StatefulWidget {
  const ForgetPassScreen({super.key});

  @override
  State<ForgetPassScreen> createState() => _ForgetPassScreenState();
}

class _ForgetPassScreenState extends State<ForgetPassScreen> {
  final TextEditingController emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomPassAppBar(),
      body: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthLoading) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (_) => const Center(child: CircularProgressIndicator()),
            );
          }

          if (state is AuthInitial) {
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("reset_email_sent".tr()),
                backgroundColor: AppColors.green,
              ),
            );
          }

          if (state is AuthFailure) {
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error),
                backgroundColor: AppColors.red,
              ),
            );
          }
        },
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: context.locale.languageCode == 'ar'
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
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
                  'enter_email_msg'.tr(),
                  style: TextStyle(
                    fontSize: 20.sp,
                    color: Colors.grey[700],
                    height: 1.2,
                  ),
                  textAlign: context.locale.languageCode == 'ar'
                      ? TextAlign.right
                      : TextAlign.center,
                ),
                Gap(60.h),
                Text(
                  'email'.tr(),
                  style: TextStyle(
                    fontSize: 17.sp,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Gap(5.h),
                SizedBox(
                  width: double.infinity,
                  child: CustomTextField(
                    validator: (p0) =>
                        AppValidators.emailValidator(emailController.text),
                    hint: "enter_email".tr(),
                    controller: emailController,
                    prefixIcon: SvgPicture.asset(AppIcons.emailIcon),
                  ),
                ),
                Gap(40.h),
                Center(
                  child: CustomButton(
                    text: 'send_link'.tr(),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        context.read<AuthCubit>().resetPassword(
                          emailController.text,
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
