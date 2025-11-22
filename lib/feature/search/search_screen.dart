import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kheet_amal/core/widgets/custom_app_bar.dart';
import 'package:kheet_amal/feature/search/widgets/custom_search_row.dart';
import 'package:kheet_amal/feature/search/widgets/custom_search_failed.dart';
import 'package:kheet_amal/feature/search/widgets/custom_search_success.dart'; 

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'search'.tr(),),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25.w),
        child: Column(
          children: [
            SizedBox(height: 20.h),
             customSearchRow(context: context),
            SizedBox(height: 30.h),
            customSearchSuccess(context: context),
          ],
        ),
      ),
    );
  }
}