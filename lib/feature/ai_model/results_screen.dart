import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kheet_amal/core/utils/app_colors.dart';

class ResultScreen extends StatelessWidget {
  final File resultFile;
  const ResultScreen({super.key, required this.resultFile});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "result_page_title".tr(),
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColors.black,
            fontSize: 32.sp,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 0.7.sh,
            child: Padding(
              padding: EdgeInsets.all(20.r),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.r),
                child: resultFile.existsSync()
                    ? Image.file(
                        resultFile,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        errorBuilder: (_, __, ___) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.error, color: Colors.red, size: 60),
                              SizedBox(height: 15.h),
                              Text(
                                "result_load_error".tr(),
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          );
                        },
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.error, color: Colors.red, size: 60),
                          SizedBox(height: 16.h),
                          Text(
                            "file_not_found".tr(),
                            style: TextStyle(
                              fontSize: 16.sp,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
              ),
            ),
          ),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "conversion_result".tr(),
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.black,
                        ),
                        textAlign: TextAlign.right,
                      ),
                      SizedBox(height: 6.h),
                    ],
                  ),
                ),
                SizedBox(width: 12.w),
                Icon(Icons.check_circle, color: Colors.green, size: 36.sp),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
