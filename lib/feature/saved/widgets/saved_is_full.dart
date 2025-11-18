import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:kheet_amal/core/utils/app_colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kheet_amal/feature/my_reports_screen/widgets/report_custom_card.dart';

class Fullsaved extends StatelessWidget {
  final List<QueryDocumentSnapshot> savedDocs;

  Fullsaved({required this.savedDocs});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: savedDocs.length,
      itemBuilder: (context, index) {
        var data = savedDocs[index].data() as Map<String, dynamic>;
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
          child: ReportCard(reportData: data),
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
