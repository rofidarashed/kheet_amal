import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:kheet_amal/core/utils/app_colors.dart';
import 'package:kheet_amal/feature/home/data/models/report_model.dart';
import 'package:kheet_amal/feature/home/presentation/widgets/child_card.dart';

class Fullsaved extends StatelessWidget {
  final List<ReportModel> savedReports;

  const Fullsaved({required this.savedReports, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: savedReports.length,
      itemBuilder: (context, index) {
        final report = savedReports[index];
        
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
          child: ChildCard(
            report: report,
            theme: Theme.of(context),
          ),
        );
      },
      separatorBuilder: (context, index) => Divider(
        color: AppColors.divider,
        thickness: 1,
        indent: 16,
        endIndent: 16,
      ),
    );
  }
}