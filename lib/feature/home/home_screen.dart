import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kheet_amal/core/widgets/custom_app_bar.dart';
import 'package:kheet_amal/feature/home/widgets/segment_tab.dart';
import 'package:kheet_amal/feature/home/widgets/info_banner.dart';
import 'package:kheet_amal/feature/home/widgets/child_card.dart';
import 'package:kheet_amal/feature/report_details/screen/report_details.dart';

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

  Widget _buildInfoBanner() {
    final bool isMissing = _selectedTabIndex == 0;
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: isMissing ? const Color(0xFFFADADA) : const Color(0xFFFFF1C9),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            isMissing ? Icons.warning_amber_rounded : Icons.error_outline,
            size: 26.sp,
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Text(
                  isMissing
                      ? 'missingBannerTitle'.tr()
                      : 'suspectsBannerTitle'.tr(),
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 6.h),
                Text(
                  isMissing
                      ? 'missingBannerDesc'.tr()
                      : 'suspectsBannerDesc'.tr(),
                  style: TextStyle(
                    fontSize: 13.sp,
                    color: Colors.black87,
                    height: 1.3,
                  ),
                  textAlign: TextAlign.right,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SegmentTab extends StatelessWidget {
  const _SegmentTab({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(10.r),
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFBFD5E7) : Colors.white,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w700,
            color: isSelected ? Colors.black : Colors.black54,
          ),
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Expanded(
          child: Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16.sp),
            textAlign: TextAlign.right,
          ),
        ),
        SizedBox(width: 4.w),
        Text(
          label,
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16.sp),
        ),
      ],
    );
  }
}
