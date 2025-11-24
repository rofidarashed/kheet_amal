import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kheet_amal/core/utils/app_colors.dart';
import 'package:intl/intl.dart';

class ReportCard extends StatelessWidget {
  final Map<String, dynamic>? reportData;

  const ReportCard({super.key, this.reportData});

  @override
  Widget build(BuildContext context) {
    final data = reportData ?? {};

    // Format createdAt safely
    String createdAtString = "Unknown";
    if (data['createdAt'] != null) {
      if (data['createdAt'] is Timestamp) {
        createdAtString = DateFormat('yyyy-MM-dd – kk:mm')
            .format((data['createdAt'] as Timestamp).toDate());
      } else if (data['createdAt'] is String) {
        createdAtString = data['createdAt'];
      }
    }

    // Image URL
    final imageUrl = data['imageUrl'] ?? '';

    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20.r),
      ),
      width: double.infinity,
      padding: EdgeInsets.all(15.w),
      child: Column(
        children: [
          Row(
            children: [
              // Image container
              Container(
                width: 80.w,
                height: 80.h,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.r),
                  child: imageUrl.isNotEmpty
                      ? Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!
                              : null,
                        ),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) => Icon(
                      Icons.broken_image,
                      size: 50.sp,
                      color: Colors.grey,
                    ),
                  )
                      : Icon(Icons.person, size: 50.sp, color: Colors.grey),
                ),
              ),
              SizedBox(width: 20.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${'Name'.tr()}: ${data['childName'] ?? '---'}",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 16.sp),
                    ),
                    Text(
                      "${'Age'.tr()}: ${data['startAge'] ?? '---'} - ${data['endAge'] ?? '---'}",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 14.sp),
                    ),
                    Text(
                      "${'location'.tr()}: ${data['place'] ?? '---'}",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 14.sp),
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      "${'Description'.tr()}: ${data['description'] ?? '---'}",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 14.sp),
                    ),
                    SizedBox(height: 8.h),
                    TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: AppColors.secondaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40.r),
                        ),
                        padding: EdgeInsets.symmetric(
                            horizontal: 12.w, vertical: 8.h),
                        fixedSize: Size(160.w, 32.h),
                      ),
                      onPressed: () {},
                      child: Text(
                        "details".tr(),
                        style: TextStyle(color: AppColors.white, fontSize: 16.sp),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 7.h),
          Row(
            children: [
              Icon(Icons.favorite_border, color: AppColors.black, size: 20),
              SizedBox(width: 4.w),
              Text('${data['likes'] ?? 0}',
                  style: TextStyle(color: AppColors.black, fontSize: 14.sp)),
              SizedBox(width: 16.w),
              Icon(Icons.mode_comment_outlined, color: AppColors.black, size: 20),
              SizedBox(width: 4.w),
              Text('${data['comments'] ?? 0}',
                  style: TextStyle(color: AppColors.black, fontSize: 14.sp)),
              Spacer(),
              Text(
                createdAtString,
                style: TextStyle(
                    color: AppColors.inactiveTrackbarColor, fontSize: 16.sp),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
