import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kheet_amal/core/widgets/custom_app_bar.dart';
import 'package:kheet_amal/feature/home/cubit/home_cubit.dart';
import 'package:kheet_amal/feature/home/cubit/home_state.dart';
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
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state.reports.isEmpty) {
          return const Center(child: Text('No reports found.'));
        }

        final missingReports = state.reports
            .where((report) => report.reportType == 'lostChild')
            .toList();

        final suspectReports = state.reports
            .where((report) => report.reportType == 'verifyChild')
            .toList();

        final currentReports = _selectedTabIndex == 0
            ? missingReports
            : suspectReports;

        return Scaffold(
          backgroundColor: const Color(0xFFF7F7F7),
          appBar: CustomAppBar(
            notificationsCount: _notificationsCount,
            title: 'homeTitle'.tr(),
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
            child: Column(
              children: [
                _buildSegmentedTabs(),
                SizedBox(height: 12.h),
                InfoBanner(selectedTabIndex: _selectedTabIndex),
                SizedBox(height: 12.h),
                Expanded(
                  child: currentReports.isEmpty
                      ? Center(
                          child: Text(
                            _selectedTabIndex == 0
                                ? 'No missing children reports.'
                                : 'No suspect reports.',
                            style: TextStyle(color: Colors.grey.shade600),
                          ),
                        )
                      : ListView.builder(
                          itemCount: currentReports.length,
                          itemBuilder: (context, index) {
                            final report = currentReports[index];
                            return ChildCard(theme: theme, report: report);
                          },
                        ),
                ),
              ],
            ),
          ),
        );
      },
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
