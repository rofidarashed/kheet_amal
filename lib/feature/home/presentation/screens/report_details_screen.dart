import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kheet_amal/core/utils/app_colors.dart';
import 'package:kheet_amal/feature/home/data/models/report_model.dart';
import 'package:kheet_amal/feature/home/presentation/widgets/custom_founder_info.dart';
import 'package:kheet_amal/feature/home/presentation/widgets/custom_icon_button.dart';
import 'package:kheet_amal/feature/home/presentation/widgets/custom_report_action_bar.dart';
import 'package:kheet_amal/feature/home/presentation/widgets/custom_report_details_cards.dart';
import 'package:kheet_amal/feature/saved_reports/cubits/saved_reports_cubit/saved_reports_cubit.dart';
import 'package:kheet_amal/feature/saved_reports/cubits/saved_reports_cubit/saved_reports_state.dart';
import 'package:kheet_amal/support_reports/cubits/sup_reports_cubit/supprot_reports_cubit.dart';

class ReportDetails extends StatelessWidget {
  const ReportDetails({super.key, required this.report});

  final ReportModel report;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<SavedReportsCubit>().checkIfSaved(report.id);
    });
    return Scaffold(
      appBar: AppBar(
        title: const Text('report_details').tr(),
        centerTitle: true,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 26.w),
            child: BlocBuilder<SavedReportsCubit, SavedReportsState>(
              builder: (context, state) {
                bool isSaved = false;
                if (state is SavedReportsToggled &&
                    state.reportId == report.id) {
                  isSaved = state.isSaved;
                }

                return GestureDetector(
                  onTap: () {
                    context.read<SavedReportsCubit>().toggleSaveReport(
                      report.id,
                    );
                    debugPrint(
                      '============================${report
                          .id}============================',
                    );
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                    child: SvgPicture.asset(
                      isSaved
                          ? 'assets/svgs/isSaved_svg.svg'
                          : 'assets/svgs/save_icon_svg.svg',
                      width: 24.w,
                      height: 24.h,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 64.sp,
                width: double.infinity,
                color: AppColors.sGreen,
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                        child: Text(
                          "ai_hint",
                          textAlign: TextAlign.right,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400,
                            height: 1.5.h,
                          ),
                        ).tr(),
                      ),
                    ),
                    Image.asset(
                      "assets/images/report_details.png",
                      height: 25.sp,
                      width: 25.sp,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 14.h),
              Container(
                alignment: Alignment.center,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15.sp),
                  child: report.imageUrl.isNotEmpty
                      ? Image.network(
                    report.imageUrl,
                    height: 187.h,
                    width: 158.w,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) =>
                        SvgPicture.asset(
                          'assets/svgs/profile_icon.svg',
                          height: 187.h,
                          width: 158.w,
                          fit: BoxFit.cover,
                        ),
                  )
                      : Container(),
                ),
              ),
              SizedBox(height: 20.h),
              FounderInfo(),
              ReportDetailsCardsColumn(report: report),
              SizedBox(height: 16.h),
              ReportActionBar(
                space: 16.w,
                onPressed: () {},
                actionChild: CustomIconButton(
                  text: 'share'.tr(),
                  backgroundColor: AppColors.secondaryColor,
                  onPressed: () {},
                  icon: Icon(
                      Icons.share, color: AppColors.white, size: 20.sp),
                ), report: report,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
