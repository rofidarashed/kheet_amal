import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kheet_amal/core/utils/app_colors.dart';
import 'package:kheet_amal/core/utils/app_icons.dart';
import 'package:kheet_amal/core/widgets/custom_confirm_dialog.dart';
import 'package:kheet_amal/feature/home/data/models/report_model.dart';
import 'package:kheet_amal/feature/profile/cubits/cubit/my_reports_cubit.dart';
import 'package:kheet_amal/feature/profile/data/my_reports_repo.dart';
import 'package:kheet_amal/feature/profile/widgets/report_is_empty.dart';
import 'package:kheet_amal/feature/profile/widgets/report_is_full.dart';

class MyReports extends StatelessWidget {
  const MyReports({super.key});

  static const String routeName = "reports";

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MyReportsCubit(MyReportsRepository())..loadReports(),
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: AppBar(
          title: Text("My reports".tr()),
          backgroundColor: AppColors.backgroundColor,
          centerTitle: true,
        ),
        body: BlocBuilder<MyReportsCubit, List<ReportModel>>(
          builder: (context, reports) {
            if (reports.isEmpty) {
              return EmptyReport();
            }

            return FullReport(
              myReports: reports,
              onDeleteReport: (reportId) =>
                  _showDeleteDialog(context, reportId),
            );
          },
        ),
      ),
    );
  }

  void _showDeleteDialog(BuildContext context, String reportId) {
    final cubit = context.read<MyReportsCubit>();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomConfirmationDialog(
          onPressed: () {
            cubit.deleteReport(reportId);
            Navigator.of(context).pop();

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('report_deleted'.tr()),
                backgroundColor: AppColors.sGreen,
                duration: Durations.medium3,
              ),
            );
          },
          icon: AppIcons.deleteIcon,
          title: 'are_you_sure_delete_report'.tr(),
          actionText: 'delete'.tr(),
        );
      },
    );
  }
}
