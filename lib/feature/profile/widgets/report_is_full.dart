import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kheet_amal/core/utils/app_colors.dart';
import 'package:kheet_amal/feature/my_reports_screen/widgets/report_custom_card.dart';
import 'package:flutter/material.dart';

class FullReport extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListView.separated(
        itemBuilder: (context , index) => Padding(
          padding: EdgeInsets.only(left: 10.w ,right: 10.w),
          child: ReportCard(),
        ) ,
        separatorBuilder: (context , index) => Divider(
          color: AppColors.divider,
          thickness: 1,
          indent: 16,
          endIndent: 16,
        ),
        itemCount: 30);
  }

}