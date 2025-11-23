import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
      supportedLocales: [Locale('ar'), Locale('en')],
      path: 'assets/translations',
      fallbackLocale: Locale('ar'),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Contact App',
          theme: ThemeData(primarySwatch: Colors.blue),
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          home: const ContactPage(),
        );
      },
    );
  }
}

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: Text(
          "contact_us".tr(),
          style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              "contact_intro".tr(),
              style: TextStyle(fontSize: 18.sp),
              textAlign: TextAlign.right,
            ),
            SizedBox(height: 25.h),
            Text(
              "contact_info".tr(),
              style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold),
              textAlign: TextAlign.right,
            ),
            SizedBox(height: 10.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "contact_email".tr(),
                        style: TextStyle(fontSize: 18.sp, color: Colors.black),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.right,
                ),
                SizedBox(width: 8.w),
                Icon(Icons.email, color: Colors.blue, size: 18.sp),
              ],
            ),
            SizedBox(height: 8.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "contact_phone".tr(),
                  style: TextStyle(fontSize: 18.sp),
                  textAlign: TextAlign.right,
                ),
                SizedBox(width: 8.w),
                Icon(Icons.phone, color: Colors.blue, size: 18.sp),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
