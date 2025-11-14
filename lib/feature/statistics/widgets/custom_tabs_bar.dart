import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kheet_amal/feature/statistics/widgets/custom_tab_container.dart';

class CustomTabsBar extends StatefulWidget {
  const CustomTabsBar({super.key, required this.onTabChanged});
  final Function(int) onTabChanged;

  @override
  State<CustomTabsBar> createState() => _CustomTabsBarState();
}

class _CustomTabsBarState extends State<CustomTabsBar> {
  int selectedIndex = 0;

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
            isSelected: selectedIndex == 0,
            onTap: () {
              setState(() {
                selectedIndex = 0;
                widget.onTabChanged(selectedIndex);
              });
            },
          ),
          CustomTabContainer(
            title: 'summary'.tr(),
            isSelected: selectedIndex == 1,
            onTap: () {
              setState(() {
                selectedIndex = 1;
                widget.onTabChanged(selectedIndex);
              });
            },
          ),
        ],
      ),
    );
  }
}
