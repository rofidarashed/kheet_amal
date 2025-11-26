import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kheet_amal/core/widgets/custom_app_bar.dart';
import 'package:kheet_amal/feature/home/cubit/home_cubit.dart';
import 'package:kheet_amal/feature/home/cubit/home_state.dart';
import 'package:kheet_amal/feature/home/data/models/report_model.dart';
import 'package:kheet_amal/feature/home/presentation/widgets/info_banner.dart';
import 'package:kheet_amal/feature/home/presentation/widgets/child_card.dart';
import 'package:kheet_amal/core/widgets/custom_tabs_bar.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../saved/cubits/saved_reports_cubit/saved_reports_cubit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        final missingReports = state.reports
            .where((report) => report.reportType == 'lostChild')
            .toList();

        final suspectReports = state.reports
            .where((report) => report.reportType == 'verifyChild')
            .toList();

        final currentReports = _selectedTabIndex == 0
            ? missingReports
            : suspectReports;

        return Skeletonizer(
          enabled: state.isLoading || state.reports.isEmpty,
          child: Scaffold(
            backgroundColor: const Color(0xFFF7F7F7),
            appBar: CustomAppBar(
              title: 'homeTitle'.tr(),
            ),
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
              child: Column(
                children: [
                  CustomTabsBar(
                    onTabChanged: (index) {
                      setState(() {
                        _selectedTabIndex = index;
                      });
                    },
                    tabTitle1: 'missingTab'.tr(),
                    tabTitle2: 'suspectsTab'.tr(),
                  ),
                  SizedBox(height: 12.h),
                  InfoBanner(selectedTabIndex: _selectedTabIndex),
                  SizedBox(height: 12.h),
                  Expanded(
                    child: state.isLoading
                        ? ListView.builder(
                            // skeleton
                            itemCount: 6,
                            itemBuilder: (_, __) => BlocProvider(
                              create: (context) => SavedReportsCubit(),
                              child: ChildCard(
                                theme: theme,
                                report: ReportModel.empty(),
                                isSkeleton: true,
                              ),
                            ),
                          )
                        : currentReports.isEmpty
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
                              return BlocProvider(
                                create: (context) => SavedReportsCubit(),
                                child: ChildCard(
                                  theme: theme,
                                  report: report,
                                  isSkeleton: false,
                                ),
                              );
                            },
                          ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
