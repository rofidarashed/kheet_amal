import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kheet_amal/feature/home/data/models/report_model.dart';
import 'package:kheet_amal/feature/home/presentation/widgets/child_card.dart';

Widget customSearchSuccess({
  required BuildContext context,
  required List<ReportModel> results,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 10.h),

      // Align(
      //   alignment: Alignment.topRight,
      //   child: Text(
      //     "latest_cases".tr(),
      //     style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.w400),
      //   ),
      // ),
      // SizedBox(height: 16.h),
      ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: results.length,
        itemBuilder: (context, index) {
          final doc = results[index];

          return Padding(
            padding: EdgeInsets.symmetric(vertical: 8.h),
            child: ChildCard(theme: Theme.of(context), report: doc),
          );
        },
      ),
    ],
  );
}
