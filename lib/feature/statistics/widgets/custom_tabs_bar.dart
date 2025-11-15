import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kheet_amal/feature/statistics/widgets/custom_tab_container.dart';

class CustomTabsBar extends StatefulWidget {
  const CustomTabsBar({super.key, required this.onTabChanged, required this.tabTitle1, required this.tabTitle2});
  final Function(int) onTabChanged;
  final String tabTitle1;
  final String tabTitle2;

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
            title: widget.tabTitle1,
            isSelected: selectedIndex == 0,
            onTap: () {
              setState(() {
                selectedIndex = 0;
                widget.onTabChanged(selectedIndex);
              });
            },
          ),
          CustomTabContainer(
            title: widget.tabTitle2,
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
