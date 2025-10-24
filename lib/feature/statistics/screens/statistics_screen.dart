import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kheet_amal/core/utils/app_icons.dart';
import 'package:kheet_amal/feature/statistics/widgets/summary_screen.dart';
import 'package:kheet_amal/feature/statistics/widgets/custom_tabs_bar.dart';
import 'package:kheet_amal/feature/statistics/widgets/performance_column.dart';

class StatisticsScreen extends StatefulWidget {
  const StatisticsScreen({super.key});

  @override
  State<StatisticsScreen> createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('statistics'.tr()),
            SvgPicture.asset(AppIcons.lineChart),
          ],
        ),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: SvgPicture.asset(AppIcons.backIcon),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        child: SafeArea(
          child: Column(
            children: [
              CustomTabsBar(
                onTabChanged: (index) {
                  setState(() {
                    selectedIndex = index;
                  });
                },
              ),
              SizedBox(height: 7.h),

              selectedIndex == 0 ? PerformanceColumn() : SummaryScreen1(),
            ],
          ),
        ),
      ),
    );
  }
}
