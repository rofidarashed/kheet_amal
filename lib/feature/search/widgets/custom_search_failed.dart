import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kheet_amal/core/utils/app_colors.dart';
import 'package:kheet_amal/feature/filter/filter_screen.dart';

Widget customSearchFailed({
  required BuildContext context,
  required Function(List<DocumentSnapshot>) updateResults,
}) {

  Future<void> fetchLatestCases() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('reports')
          .orderBy('createdAt', descending: true)
          .limit(10)
          .get();


      updateResults(querySnapshot.docs);
    } catch (e) {
      if (e is FirebaseException) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('خطأ في جلب أحدث الحالات: ${e.message}')),
        );
      }
      print('Error fetching latest cases: $e');
    }
  }

  return Column(
    children: [
      SizedBox(height: 24.h),
      Center(
        child: Image.asset(
          "assets/images/image.png",
          height: 200.h,
          width: 180.w,
          fit: BoxFit.contain,
          semanticLabel: 'صورة عدم وجود نتائج البحث',
        ),
      ),
      SizedBox(height: 24.h),
      Text(
        "change_governorate".tr(),
        textAlign: TextAlign.center,
        style: TextStyle(
          color: AppColors.black,
          fontSize: 20.sp,
          fontWeight: FontWeight.w400,
        ),
        semanticsLabel: 'تغيير معايير البحث أو المحافظة',
      ),
      SizedBox(height: 24.h),
      ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => FilterScreen()),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.secondaryColor,
          minimumSize: Size(double.infinity, 48.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40.r),
          ),
        ),
        child: Text(
          "reset_filters".tr(),
          semanticsLabel: 'إعادة ضبط الفلاتر',
          style: TextStyle(
            color: AppColors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      SizedBox(height: 16.h),
      ElevatedButton(
        onPressed: fetchLatestCases,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.backgroundColor,
          minimumSize: Size(double.infinity, 48.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40.r),
          ),
          elevation: 0,
        ),
        child: Text(
          "show_latest_cases".tr(),
          semanticsLabel: 'عرض أحدث الحالات',
          style: TextStyle(
            color: AppColors.secondaryColor,
            fontSize: 18.sp,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    ],
  );
}