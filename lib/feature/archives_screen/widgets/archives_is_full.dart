import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kheet_amal/core/utils/app_colors.dart';

import 'archives_custom_card.dart';

class FullArchives extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListView.separated(
        itemBuilder: (context , index) => Padding(
          padding: EdgeInsets.only(left: 10.w ,right: 10.w),
          child: ArchivesCard(),
        ) ,
        separatorBuilder: (context , index) => Divider(
          color: AppColors.divider,
          thickness: 1,
          indent: 16,
          endIndent: 16,
        ),
        itemCount: 30);
  }

}