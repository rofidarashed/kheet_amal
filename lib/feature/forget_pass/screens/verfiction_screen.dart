import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:kheet_amal/feature/forget_pass/widgets/custom_appbar.dart';
import 'package:pinput/pinput.dart';
import '../../../core/routing/app_routes.dart';
import '../../../core/utils/app_colors.dart';
import '../widgets/custom_button.dart';
import 'package:easy_localization/easy_localization.dart';

class VerificationScreen extends StatefulWidget {
  final String phoneNumber;

  const VerificationScreen({super.key, required this.phoneNumber});

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  Timer? _timer;
  int _remainingSeconds = 60;
  bool _isResendEnabled = false;

  String _code = "";

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _isResendEnabled = false;
    _remainingSeconds = 60;

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_remainingSeconds > 0) {
          _remainingSeconds--;
        } else {
          _isResendEnabled = true;
          _timer?.cancel();
        }
      });
    });
  }

  void _verifyCode() {
    if (_code.length == 4) {
      Navigator.of(context).pushNamed(AppRoutes.newPass);
    }
  }

  void _resendCode() {
    print('Resending code to ${widget.phoneNumber}');
    _startTimer();
    setState(() {
      _code = "";
    });
  }

  String _formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return '$minutes:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: SafeArea(
        child: Center(
          // 🔥 بيخلي كل المحتوى في النص
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center, // 🔥 عمودي في النص
              crossAxisAlignment: CrossAxisAlignment.center, // 🔥 أفقي في النص
              children: [
                SizedBox(height: 40.h),

                /// العنوان
                Text(
                  "enter_verification_code".tr(),
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),

                SizedBox(height: 16.h),

                /// الوصف
                Text(
                  "enter_verification_code_msg".tr(),
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.grey[600],
                    height: 1.5,
                  ),
                  textAlign: TextAlign.center,
                ),

                SizedBox(height: 40.h),

                /// مربعات إدخال الكود
                Pinput(
                  length: 4,
                  showCursor: true,
                  onChanged: (value) => setState(() => _code = value),
                  onCompleted: (value) {
                    _code = value;
                    _verifyCode();
                  },
                  defaultPinTheme: PinTheme(
                    width: 60.w,
                    height: 60.h,
                    textStyle: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: AppColors.primaryColor,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                  focusedPinTheme: PinTheme(
                    width: 60.w,
                    height: 60.h,
                    textStyle: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: AppColors.secondaryColor,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                ),

                SizedBox(height: 24.h),

                if (!_isResendEnabled)
                  Text(
                    '${"resend_code".tr()} ${_formatTime(_remainingSeconds)}',
                    style: TextStyle(fontSize: 14.sp, color: Colors.grey[600]),
                    textAlign: TextAlign.center,
                  ),

                SizedBox(height: 32.h),

                CustomButton(text: "confirm_code".tr(), onPressed: _verifyCode),

                SizedBox(height: 24.h),

                GestureDetector(
                  onTap: _isResendEnabled ? _resendCode : null,
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "${"did_not_receive_code".tr()} ",
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.grey[600],
                          ),
                        ),
                        TextSpan(
                          text: "resend".tr(),
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: _isResendEnabled
                                ? AppColors.secondaryColor
                                : Colors.grey[400],
                            fontWeight: FontWeight.w600,
                            decoration: _isResendEnabled
                                ? TextDecoration.underline
                                : null,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 400.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
