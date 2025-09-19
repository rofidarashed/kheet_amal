import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return Scaffold(
          body: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Image.asset(
                    "assets/images/logo.png",
                    height: 230.h,
                    width: 230.w,
                  ),
                ),
                SizedBox(height: 10.h),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 23.w, 0),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Text(
                      "تسجيل الدخول",
                      style: TextStyle(
                        fontSize: 32.sp,
                        fontWeight: FontWeight.w400,
                      ),
                      textDirection: TextDirection.rtl,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 5.h, 33.w, 0),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Text(
                      "اسم المستخدم",
                      style: TextStyle(
                        fontSize: 21.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(20.w, 6.h, 33.w, 0),
                  child: SizedBox(
                    width: 380.w,
                    height: 45.h,
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: "ادخل اسم المستخدم",
                        hintTextDirection: TextDirection.rtl,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.r),
                          borderSide: const BorderSide(color: Colors.blue),
                        ),
                        suffixIcon: Padding(
                          padding: EdgeInsets.all(7.w),
                          child: Image.asset(
                            "assets/images/user-circle.png",
                            height: 15.h,
                            width: 15.w,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(20.w, 10.h, 33.w, 0),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Text(
                      "كلمة المرور",
                      style: TextStyle(
                        fontSize: 21.sp,
                        fontWeight: FontWeight.w400,
                      ),
                      textDirection: TextDirection.rtl,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(20.w, 6.h, 33.w, 0),
                  child: SizedBox(
                    width: 380.w,
                    height: 45.h,
                    child: TextFormField(
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: "ادخل كلمة المرور",
                        hintTextDirection: TextDirection.rtl,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.r),
                          borderSide: const BorderSide(color: Colors.blue),
                        ),
                        suffixIcon: Padding(
                          padding: EdgeInsets.all(7.w),
                          child: Image.asset(
                            "assets/images/pass_sign.png",
                            height: 5.h,
                            width: 5.w,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.w),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: TextButton(
                      onPressed: () {},
                      child: Text(
                        "نسيت كلمة المرور؟",
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w400,
                          color: Colors.orange,
                        ),
                        textDirection: TextDirection.rtl,
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(0, 40.h, 0, 0),
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        minimumSize: Size(307.w, 45.h),
                      ),
                      child: Text(
                        "تسجيل",
                        style: TextStyle(
                          fontSize: 24.sp,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                        textDirection: TextDirection.rtl,
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "أنشئ حساب جديد",
                      style: TextStyle(
                        fontSize: 21.sp,
                        fontWeight: FontWeight.w400,
                        color: Colors.orange,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.w),
                      child: Text(
                        "ليس لديك حساب؟",
                        style: TextStyle(
                          fontSize: 21.sp,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
