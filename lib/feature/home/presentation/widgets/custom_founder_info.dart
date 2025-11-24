import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kheet_amal/core/utils/app_colors.dart';
import 'package:kheet_amal/feature/home/data/models/report_model.dart';
import 'package:timeago/timeago.dart' as timeago;

class FounderInfo extends StatelessWidget {
  final ReportModel report;

  const FounderInfo({super.key, required this.report});

  Future<String> _fetchUserName(String userId) async {
    if (userId.isEmpty) return 'Unknown';
    try {
      final doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();

      if (doc.exists) {
        final data = doc.data();
        return data?['name'] ??
            data?['userName'] ??
            data?['displayName'] ??
            'Unknown';
      }
    } catch (e) {
      debugPrint('Error fetching user name: $e');
    }
    return 'Unknown';
  }

  @override
  Widget build(BuildContext context) {
      final locale = _getSafeLocale(context);

    final timeString = timeago.format(
      report.createdAt,
      locale: locale
    );
    return Padding(
      padding: EdgeInsets.fromLTRB(25.w, 0, 25.w, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            timeString,
            style: TextStyle(color: AppColors.black, fontSize: 13.sp),
          ),
          const Spacer(),

          FutureBuilder<String>(
            future: _fetchUserName(report.userId ?? ''),
            builder: (context, snapshot) {
              String displayName = report.userName.isNotEmpty
                  ? report.userName
                  : "...";

              if (snapshot.hasData) {
                displayName = snapshot.data!;
              }

              return Text(
                " $displayName",
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.black,
                ),
              );
            },
          ),

          Text("posted_by").tr(),
        ],
      ),
    );
  }
  String? _getSafeLocale(BuildContext context) {
    try {
      final locale = context.locale;
      return locale.languageCode;
    } catch (e) {
      debugPrint('EasyLocalization not available in this context: $e');
      return null;
    }
  }
}
