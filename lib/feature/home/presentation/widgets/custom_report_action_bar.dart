import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../support_reports/cubits/sup_reports_cubit/supprot_reports_cubit.dart';
import '../../../support_reports/cubits/sup_reports_cubit/supprot_reports_state.dart';
import '../../data/models/report_model.dart';

class ReportActionBar extends StatelessWidget {
  const ReportActionBar({
    super.key,
    required this.onPressed,
    required this.actionChild,
    this.space,
    required this.report,
  });
  final VoidCallback onPressed;
  final Widget actionChild;
  final double? space;
  final ReportModel report;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(width: space ?? 0),
          BlocBuilder<SupportReportsCubit, SupportReportsState>(
            builder: (context, state) {
              bool isSupported = false;
              if (state is SupportReportsToggled &&
                  state.reportId == report.id) {
                isSupported = state.isSupported;
              }

              return GestureDetector(
                onTap: () {
                  context.read<SupportReportsCubit>().toggleSupport(report.id);
                },
                child: SvgPicture.asset(
                  isSupported
                      ? 'assets/svgs/supported.svg'
                      : 'assets/svgs/support.svg',
                  height: 22.h,
                  width: 22.w,
                ),
              );
            },
          ),

          SizedBox(width: 5.w),
          Text('20', style: TextStyle(fontSize: 16.sp)),
          SizedBox(width: 25.w),
          InkWell(
            onTap: () {},
            child: Image.asset(
              "assets/images/messages_icon.png",
              height: 20.h,
              width: 20.w,
            ),
          ),
          SizedBox(width: 5.w),
          Text('20', style: TextStyle(fontSize: 16.sp)),
          Spacer(),
          Padding(
            padding: EdgeInsets.fromLTRB(0, 0.h, 8.w, 0.h),
            child: actionChild,
          ),
        ],
      ),
    );
  }
}
