import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kheet_amal/core/widgets/custom_app_bar.dart';
import 'package:kheet_amal/feature/home/presentation/widgets/segment_tab.dart';
import 'package:kheet_amal/feature/home/presentation/widgets/info_banner.dart';
import 'package:kheet_amal/feature/home/presentation/widgets/child_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedTabIndex = 0;
  int _notificationsCount = 3;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      appBar: CustomAppBar(
        notificationsCount: _notificationsCount,
        title: 'homeTitle'.tr(),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
        children: [
          _buildSegmentedTabs(),
          SizedBox(height: 12.h),
          InfoBanner(selectedTabIndex: _selectedTabIndex),
          SizedBox(height: 12.h),
          ChildCard(theme: theme),
        ],
      ),
    );
  }

  Widget _buildSegmentedTabs() {
    return Container(
      height: 48.h,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.r)),
      child: Row(
        children: [
          Expanded(
            child: SegmentTab(
              label: 'missingTab'.tr(),
              isSelected: _selectedTabIndex == 0,
              onTap: () => setState(() => _selectedTabIndex = 0),
            ),
          ),
          Expanded(
            child: SegmentTab(
              label: 'suspectsTab'.tr(),
              isSelected: _selectedTabIndex == 1,
              onTap: () => setState(() => _selectedTabIndex = 1),
            ),
          ),
        ],
      ),
    );
  }

}
