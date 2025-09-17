import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:kheet_amal/core/routing/app_router.dart';
import 'package:kheet_amal/core/routing/app_routes.dart';
import '../../../core/utils/app_colors.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_pass_feild.dart';

class NewPasswordPage extends StatefulWidget {
  const NewPasswordPage({Key? key}) : super(key: key);

  @override
  _NewPasswordPageState createState() => _NewPasswordPageState();
}

class _NewPasswordPageState extends State<NewPasswordPage> {
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  bool _isNewPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _handlePasswordReset() {
    if (_formKey.currentState?.validate() ?? false) {
    Navigator.of(context).pushNamed(AppRoutes.passSuccess);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black, size: 20.sp),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(24.w),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              Text(
                "reset_password".tr(),
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              Gap(8.h),

              // Subtitle
              Text(
                "new_password_different".tr(),
                style: TextStyle(
                  fontSize: 16.sp,
                  color: Colors.grey[600],
                  height: 1.4,
                ),
              ),
              Gap(40.h),

              // New Password Field
              CustomPasswordField(
                label: "new_password".tr(),
                hint: "enter_new_password".tr(),
                controller: _newPasswordController,
                isPasswordVisible: _isNewPasswordVisible,
                toggleVisibility: () {
                  setState(() {
                    _isNewPasswordVisible = !_isNewPasswordVisible;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "enter_new_password".tr();
                  }
                  if (value.length < 6) {
                    return "Password must be at least 6 characters";
                  }
                  return null;
                },
              ),
              Gap(24.h),

              // Confirm Password Field
              CustomPasswordField(
                label: "confirm_new_password".tr(),
                hint: "enter_new_password_again".tr(),
                controller: _confirmPasswordController,
                isPasswordVisible: _isConfirmPasswordVisible,
                toggleVisibility: () {
                  setState(() {
                    _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "enter_new_password_again".tr();
                  }
                  if (value != _newPasswordController.text) {
                    return "Passwords do not match";
                  }
                  return null;
                },
              ),

              Gap(40.h),

              // Confirm Button
              Center(
                child: CustomButton(
                  text: "confirm".tr(),
                  onPressed: _handlePasswordReset,
                ),
              ),
              Gap(20.h),
            ],
          ),
        ),
      ),
    );
  }
}
