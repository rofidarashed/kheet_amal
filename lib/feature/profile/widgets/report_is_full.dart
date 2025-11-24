import 'package:flutter/material.dart';
import 'package:kheet_amal/feature/home/data/models/report_model.dart';
import 'package:kheet_amal/feature/home/presentation/widgets/child_card.dart';

class FullReport extends StatelessWidget {
  final List<ReportModel> myReports;
  final Function(String) onDeleteReport;

  const FullReport({
    required this.myReports,
    required this.onDeleteReport,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: myReports.length,
      itemBuilder: (context, index) {
        final report = myReports[index];
        return ChildCard(
          report: report,
          theme: Theme.of(context),
          showDelete: true,
          onTap: () => onDeleteReport(report.id),
        );
      },
    );
  }
}