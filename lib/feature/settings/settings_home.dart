import 'package:flutter/material.dart';
import 'package:kheet_amal/core/utils/app_colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'faq_page.dart';
import 'contact_page.dart';
import 'about_app.dart';

class SettingsHome extends StatelessWidget {
  const SettingsHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: Text(
          "settings".tr(),
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.sp),
        ),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text(
              "support_help".tr(),
              style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold),
              textAlign: TextAlign.right,
            ),
          ),

          _item(context, "faq".tr(), const FAQPage(), Icons.help_outline),

          _item(
            context,
            "contact_us".tr(),
            const ContactPage(),
            Icons.contact_mail,
          ),

          ListTile(
            trailing: Icon(Icons.privacy_tip, color: AppColors.border),
            title: Text(
              "privacy_policy".tr(),
              textAlign: TextAlign.right,
              style: TextStyle(fontSize: 22.sp),
            ),
            leading: const Icon(Icons.arrow_back_ios, size: 22),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  contentPadding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 20.h),
                  titlePadding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 0),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Center(
                          child: Text(
                            "privacy_policy".tr(),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20.sp,
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Icon(Icons.close, size: 24.sp),
                      ),
                    ],
                  ),
                  content: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        _PrivacyItem(point: "privacy_point1".tr()),
                        _PrivacyItem(point: "privacy_point2".tr()),
                        _PrivacyItem(point: "privacy_point3".tr()),
                        _PrivacyItem(point: "privacy_point4".tr()),
                        _PrivacyItem(point: "privacy_point5".tr()),
                        _PrivacyItem(point: "privacy_point6".tr()),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),

          ListTile(
            title: Text(
              "about_app".tr(),
              style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold),
              textAlign: TextAlign.right,
            ),
          ),

          _item(
            context,
            "app_info".tr(),
            const AboutAppPage(),
            Icons.info_outline,
          ),
        ],
      ),
    );
  }

  Widget _item(BuildContext ctx, String title, Widget page, IconData icon) {
    return ListTile(
      trailing: Icon(icon, color: AppColors.border, size: 24.sp),
      title: Text(
        title,
        textAlign: TextAlign.right,
        style: TextStyle(fontSize: 22.sp),
      ),
      leading: Icon(Icons.arrow_back_ios, size: 22.sp),
      onTap: () {
        Navigator.push(ctx, MaterialPageRoute(builder: (context) => page));
      },
    );
  }
}

class _PrivacyItem extends StatelessWidget {
  final String point;

  const _PrivacyItem({super.key, required this.point});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("•  ", style: TextStyle(fontSize: 18.sp)),
          Expanded(
            child: Text(
              point,
              textAlign: TextAlign.right,
              style: TextStyle(fontSize: 18.sp),
            ),
          ),
        ],
      ),
    );
  }
}
