import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kheet_amal/core/utils/app_colors.dart';
import 'package:kheet_amal/feature/home/data/models/report_model.dart';
import 'package:kheet_amal/feature/home/presentation/widgets/child_card.dart';
import 'package:flutter/material.dart';

class FullReport extends StatelessWidget {
  final List<ReportModel> myReports;

  const FullReport({super.key, required this.myReports});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      itemBuilder: (context, index) {
        final report = myReports[index];
        return Padding(
          padding: EdgeInsets.only(left: 10.w, right: 10.w),
          child: ChildCard(
            report: report, 
            theme: Theme.of(context)
          ),
        );
      },
      separatorBuilder: (context, index) => const Divider(
        color: AppColors.divider,
        thickness: 1,
        indent: 16,
        endIndent: 16,
      ),
      itemCount: myReports.length,
    );
  }
}