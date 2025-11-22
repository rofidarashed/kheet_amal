import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kheet_amal/core/utils/app_colors.dart';
import 'package:kheet_amal/feature/home/data/models/report_model.dart';
import 'package:kheet_amal/feature/profile/data/my_reports_repo.dart';
import 'package:kheet_amal/feature/profile/widgets/report_is_empty.dart';
import 'package:kheet_amal/feature/profile/widgets/report_is_full.dart';

class MyReports extends StatelessWidget {
  const MyReports({super.key});

  static const String routeName = "reports";

  @override
  Widget build(BuildContext context) {
    final repository = MyReportsRepository();

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: Text("My reports".tr()),
        backgroundColor: AppColors.backgroundColor,
        centerTitle: true,
      ),
      body: StreamBuilder<List<ReportModel>>(
        stream: repository.getMyReportsStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return EmptyReport();
          }

          final myReports = snapshot.data!;
          return FullReport(myReports: myReports);
        },
      ),
    );
  }
}