import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kheet_amal/feature/statistics/widgets/custom_tab_container.dart';

class CustomTabsBar extends StatefulWidget {
  const CustomTabsBar({super.key});

  @override
  State<CustomTabsBar> createState() => _CustomTabsBarState();
}

class _CustomTabsBarState extends State<CustomTabsBar> {
  int isSelected = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52.h,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(11.r),
      ),
      child: Row(
        children: [
          CustomTabContainer(
            title: 'performance'.tr(),
            isSelected: isSelected == 0,
            onTap: () {
              setState(() {
                isSelected = 0;
              });
              print(isSelected);
            },
          ),
          CustomTabContainer(
            title: 'summary'.tr(),
            isSelected: isSelected == 1,
            onTap: () {
              setState(() {
                isSelected = 1;
              });
              print(isSelected);
            },
          ),
        ],
      ),
    );
  }
}
