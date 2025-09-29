import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      appBar: AppBar(
        title: Text(
          'homeTitle'.tr(),
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 22.sp),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: const Color(0xFFF7F7F7),
        surfaceTintColor: const Color(0xFFF7F7F7),
        automaticallyImplyLeading: false,
        leadingWidth: 120.w,
        actions: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 2.w),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'statistics'.tr(),
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                IconButton(
                  icon: SvgPicture.asset(
                    'assets/svgs/charts.svg',
                    width: 20.w,
                    height: 20.w,
                  ),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ],
        leading: Stack(
          children: [
            IconButton(
              icon: Icon(
                Icons.notifications_none,
                size: 25.sp,
                color: Colors.black87,
              ),
              onPressed: () {},
            ),
            if (_notificationsCount > 0)
              Positioned(
                left: 20.w,
                top: 4.h,
                child: Container(
                  padding: EdgeInsets.all(3.w),
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  constraints: BoxConstraints(minWidth: 13.w, minHeight: 13.h),
                  child: Text(
                    '$_notificationsCount',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10.sp,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
          ],
        ),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
        children: <Widget>[
          _buildSegmentedTabs(),
          SizedBox(height: 12.h),
          _buildInfoBanner(),
          SizedBox(height: 12.h),
          _buildChildCard(theme),
        ],
      ),
    );
  }

  Widget _buildSegmentedTabs() {
    return Container(
      height: 48.h,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.r)),
      child: Row(
        children: <Widget>[
          Expanded(
            child: _SegmentTab(
              label: 'missingTab'.tr(),
              isSelected: _selectedTabIndex == 0,
              onTap: () => setState(() => _selectedTabIndex = 0),
            ),
          ),
          Expanded(
            child: _SegmentTab(
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

  Widget _buildChildCard(ThemeData theme) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
      ),
      padding: EdgeInsets.all(10.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10.r),
                    child: Image.asset(
                      'assets/images/boy.png',
                      width: 120.w,
                      height: 150.h,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    top: 4.h,
                    left: 4.w,
                    child: CircleAvatar(
                      radius: 14.r,
                      backgroundColor: Colors.white70,
                      child: Icon(
                        Icons.bookmark_border,
                        color: Colors.black87,
                        size: 16.sp,
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(width: 10.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    SizedBox(height: 2.h),
                    _InfoRow(label: 'name'.tr(), value: 'احمد محمد'),
                    SizedBox(height: 6.h),
                    _InfoRow(label: 'age'.tr(), value: '7'),
                    SizedBox(height: 6.h),
                    _InfoRow(label: 'place'.tr(), value: 'مصر الجديدة'),
                    SizedBox(height: 6.h),
                    Text(
                      'since'.tr(),
                      style: TextStyle(color: Colors.black54, fontSize: 13.sp),
                      textAlign: TextAlign.right,
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 10.h),
          Row(
            children: <Widget>[
              Text('20', style: TextStyle(fontSize: 12.sp)),
              SizedBox(width: 3.w),
              Icon(Icons.chat_bubble_outline, size: 16.sp),
              SizedBox(width: 12.w),
              Text('20', style: TextStyle(fontSize: 12.sp)),
              SizedBox(width: 3.w),
              Icon(Icons.favorite_border, size: 16.sp),
              const Spacer(),
              SizedBox(
                width: 180.w,
                height: 36.h,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFF19A3E),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                  ),
                  onPressed: () {},
                  child: Text(
                    'details'.tr(),
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
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
