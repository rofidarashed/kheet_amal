import 'package:easy_localization/easy_localization.dart';
import 'package:kheet_amal/core/utils/app_colors.dart';
import 'package:kheet_amal/feature/my_reports_screen/widgets/report_is_empty.dart';
import 'package:kheet_amal/feature/my_reports_screen/widgets/report_is_full.dart';
import 'package:flutter/material.dart';

class MyReports extends StatelessWidget {
   MyReports({super.key});

  static const String routeName = "reports";

  List<String> reports = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(title: Text("My reports".tr()),backgroundColor: AppColors.backgroundColor,),
      body: reports.isEmpty ? EmptyReport() : FullReport(),
    );
  }
}
