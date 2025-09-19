import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                Image.asset("assets/images/logo.png"),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 22.w, 0),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Text(
                      "انشاء اسم المستخدم",
                      style: TextStyle(
                        fontSize: 32.sp,
                        fontWeight: FontWeight.w400,
                      ),
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
                  padding: EdgeInsets.fromLTRB(27.w, 6.h, 33.w, 0),
                  child: SizedBox(
                    width: 380.w,
                    height: 45.h,
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: "ادخل اسم المستخدم",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r),
                          borderSide: const BorderSide(color: Colors.blue),
                        ),
                        suffixIcon: Padding(
                          padding: EdgeInsets.all(7.w),
                          child: Image.asset(
                            "assets/images/user-circle.png",
                            height: 24.h,
                            width: 24.w,
                          ),
                        ),
                        hintTextDirection: TextDirection.rtl,
                      ),
                      textDirection: TextDirection.rtl,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 10.h, 33.w, 0),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Text(
                      "الرقم القومي",
                      style: TextStyle(
                        fontSize: 21.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(27.w, 6.h, 33.w, 0),
                  child: SizedBox(
                    width: 380.w,
                    height: 45.h,
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: "ادخل الرقم القومي ",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r),
                          borderSide: const BorderSide(color: Colors.blue),
                        ),
                        suffixIcon: Padding(
                          padding: EdgeInsets.all(7.w),
                          child: Image.asset(
                            "assets/images/identification-card.png",
                            height: 24.h,
                            width: 24.w,
                          ),
                        ),
                        hintTextDirection: TextDirection.rtl,
                      ),
                      textDirection: TextDirection.rtl,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 10.h, 33.w, 0),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Text(
                      "رقم الموبايل",
                      style: TextStyle(
                        fontSize: 21.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(27.w, 6.h, 33.w, 0),
                  child: SizedBox(
                    width: 380.w,
                    height: 45.h,
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: "ادخل رقم الموبايل  ",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r),
                          borderSide: const BorderSide(color: Colors.blue),
                        ),
                        suffixIcon: Padding(
                          padding: EdgeInsets.all(7.w),
                          child: Image.asset(
                            "assets/images/phone_sign.png",
                            height: 24.h,
                            width: 24.w,
                          ),
                        ),
                        hintTextDirection: TextDirection.rtl,
                      ),
                      textDirection: TextDirection.rtl,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 10.h, 33.w, 0),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Text(
                      "الرقم السري",
                      style: TextStyle(
                        fontSize: 21.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(27.w, 6.h, 33.w, 0),
                  child: SizedBox(
                    width: 380.w,
                    height: 45.h,
                    child: TextFormField(
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: "ادخل الرقم السري  ",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r),
                          borderSide: const BorderSide(color: Colors.blue),
                        ),
                        suffixIcon: Padding(
                          padding: EdgeInsets.all(7.w),
                          child: Image.asset(
                            "assets/images/pass_sign.png",
                            height: 24.h,
                            width: 24.w,
                          ),
                        ),
                        hintTextDirection: TextDirection.rtl,
                      ),
                      textDirection: TextDirection.rtl,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 10.h, 35.w, 32.h),
                  child: Row(
                    children: [
                      Expanded(
                        child: Directionality(
                          textDirection: TextDirection.rtl,
                          child: Row(
                            children: [
                              Text(
                                "أوافق على ",
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Text(
                                "الشروط و الاحكام و سياسة الخصوصية",
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.orange,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Checkbox(
                        value: false,
                        onChanged: (value) {},
                        activeColor: Colors.orange,
                      ),
                    ],
                  ),
                ),
                Center(
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
                Padding(
                  padding: EdgeInsets.all(8.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "سجل دخول",
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                          color: Colors.orange,
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        "لديك حساب بالفعل؟",
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
