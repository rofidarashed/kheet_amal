import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../profile/widgets/report_custom_card.dart';

Widget customSearchSuccess({
  required BuildContext context,
  required List<DocumentSnapshot> results,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 10.h),

      Align(
        alignment: Alignment.topRight,
        child: Text(
          "latest_cases".tr(),
          style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.w400),
        ),
      ),

      SizedBox(height: 16.h),

      ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: results.length,
        itemBuilder: (context, index) {
          final data = results[index].data() as Map<String, dynamic>;
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 8.h),
            child: ReportCard(reportData: data),
          );
        },
      ),
    ],
  );
}
