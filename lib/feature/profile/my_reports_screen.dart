import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kheet_amal/core/utils/app_colors.dart';
import 'package:kheet_amal/core/utils/app_icons.dart';
import 'package:kheet_amal/core/widgets/custom_confirm_dialog.dart';
import 'package:kheet_amal/feature/profile/cubits/cubit/my_reports_cubit.dart';
import 'package:kheet_amal/feature/profile/cubits/cubit/my_reports_state.dart';
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
        body: BlocBuilder<MyReportsCubit, MyReportsState>(
          builder: (context, state) {
            return _buildBody(context, state);
          },
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context, MyReportsState state) {
    if (state is MyReportsLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state is MyReportsError) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, color: Colors.red, size: 48),
            const SizedBox(height: 16),
            Text(
              'error_loading_reports'.tr(),
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                context.read<MyReportsCubit>().loadReports();
              },
              child: Text('retry'.tr()),
            ),
          ],
        ),
      );
    }

    if (state is MyReportsLoaded) {
      if (state.reports.isEmpty) {
        return EmptyReport();
      }

      return FullReport(
        myReports: state.reports,
        onDeleteReport: (reportId) => _showDeleteDialog(context, reportId),
      );
    }

    return const Center(child: CircularProgressIndicator());
  }

  void _showDeleteDialog(BuildContext context, String reportId) {
    // Save cubit reference BEFORE showing dialog
    final cubit = BlocProvider.of<MyReportsCubit>(context);

    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return CustomConfirmationDialog(
          onPressed: () async {
            Navigator.of(dialogContext).pop();

            // Use the saved cubit reference
            await cubit.deleteReport(reportId);

            // Show success message
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
