import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kheet_amal/core/utils/app_colors.dart';
import 'package:kheet_amal/feature/home/data/models/report_model.dart';
import 'package:kheet_amal/feature/home/presentation/screens/report_details_screen.dart';
import 'package:kheet_amal/feature/home/presentation/widgets/custom_icon_button.dart';
import 'package:kheet_amal/feature/home/presentation/widgets/custom_report_action_bar.dart';
import 'package:kheet_amal/feature/saved_reports/cubits/saved_reports_cubit/saved_reports_cubit.dart';
import '../../../../support_reports/cubits/sup_reports_cubit/supprot_reports_cubit.dart';
import '../../../saved_reports/cubits/saved_reports_cubit/saved_reports_state.dart';
import 'info_row.dart';

class ChildCard extends StatelessWidget {
  const ChildCard({super.key, required this.theme, required this.report});

  final ThemeData theme;
  final ReportModel report;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<SavedReportsCubit>().checkIfSaved(report.id);
    });
    return InkWell(
      onTap: () {
        // reuse existing cubit instances and pass them to the new route
        final savedCubit = context.read<SavedReportsCubit>();
        final supportCubit = context.read<SupportReportsCubit>();

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MultiBlocProvider(
              providers: [
                BlocProvider.value(value: savedCubit),
                BlocProvider.value(value: supportCubit),
              ],
              child: ReportDetails(report: report),
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
        ),
        padding: EdgeInsets.all(10.w),
        margin: EdgeInsets.only(bottom: 16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10.r),
                      child: report.imageUrl.isNotEmpty
                          ? Image.network(
                              report.imageUrl,
                              height: 187.h,
                              width: 158.w,
                              fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) => SvgPicture.asset(
                                'assets/svgs/profile_icon.svg',
                                height: 187.h,
                                width: 158.w,
                                fit: BoxFit.cover,
                              ),
                            )
                          : Container(),
                    ),
                    Positioned(
                      top: 4.h,
                      left: 4.w,
                      child: CircleAvatar(
                        radius: 14.r,
                        backgroundColor: Colors.white70,
                        child:
                            BlocBuilder<SavedReportsCubit, SavedReportsState>(
                              builder: (context, state) {
                                bool isSaved = false;
                                if (state is SavedReportsToggled &&
                                    state.reportId == report.id) {
                                  isSaved = state.isSaved;
                                }
                                return SvgPicture.asset(
                                  isSaved
                                      ? 'assets/svgs/isSaved_svg.svg'
                                      : 'assets/svgs/save_icon_svg.svg',
                                  width: 14.w,
                                  height: 14.h,
                                );
                              },
                            ),
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SizedBox(height: 2.h),
                      InfoRow(label: 'name'.tr(), value: report.childName),
                      SizedBox(height: 6.h),
                      InfoRow(
                        label: 'age'.tr(),
                        value: report.startAge == report.endAge
                            ? report.startAge.toString()
                            : '${report.startAge} - ${report.endAge}',
                      ),
                      SizedBox(height: 6.h),
                      InfoRow(label: 'place'.tr(), value: report.place),
                      SizedBox(height: 6.h),
                      Text(
                        'since'.tr(),
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 13.sp,
                        ),
                        textAlign: TextAlign.right,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            ReportActionBar(
              onPressed: () {},
              actionChild: CustomIconButton(
                text: 'details'.tr(),
                backgroundColor: AppColors.secondaryColor,
                onPressed: () {},
              ),
              report: report,
            ),
          ],
        ),
      ),
    );
  }
}
