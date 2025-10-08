import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kheet_amal/core/widgets/custom_app_bar.dart';
import 'package:kheet_amal/feature/search/widgets/custom_search_row.dart';
import 'package:kheet_amal/feature/search/widgets/custom_search_failed.dart'; // استدعاء SearchBody

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'search'.tr(), notificationsCount: 3),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25.w),
        child: Column(
          children: [
            SizedBox(height: 20.h),
            customSearchfailed(context: context),
            SizedBox(height: 30.h),
          ],
        ),
      ),
    );
  }
}