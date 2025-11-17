import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kheet_amal/core/utils/app_colors.dart';

Widget customSearchSuccess({
  required BuildContext context,
  required List<DocumentSnapshot> results,
}) {
  return Column(
    children: [
      SizedBox(height: 30.h),
      Center(
        child: SvgPicture.asset(
          "assets/svgs/search_image.svg",
          height: 200.h,
          width: 200.w,
        ),
      ),
      SizedBox(height: 20.h),
      Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  "search_message".tr(),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: AppColors.black,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 24.h),
          Align(
            alignment: Alignment.topRight,
            child: Text(
              "latest_cases".tr(),
              style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.w400),
            ),
          ),
          SizedBox(height: 16.h),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: results.length,
              itemBuilder: (context, index) {
                var data = results[index].data() as Map<String, dynamic>;
                return ListTile(
                  leading: data['imageUrl'] != null
                      ? Image.network(
                          data['imageUrl'],
                          height: 50.h,
                          width: 50.w,
                          fit: BoxFit.cover,
                        )
                      : const Icon(Icons.person),
                  title: Text(
                    data['childName'] ?? 'Unknown',
                    style: TextStyle(fontSize: 16.sp),
                  ),
                  subtitle: Text(
                    'Gender: ${data['gender'] ?? 'N/A'}, Age: ${data['endAge'] ?? 'N/A'}',
                    style: TextStyle(fontSize: 14.sp),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    ],
  );
}
