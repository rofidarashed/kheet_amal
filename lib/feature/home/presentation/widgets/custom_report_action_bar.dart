import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kheet_amal/feature/comments/presentation/screen/comments_screen.dart';
import 'package:kheet_amal/feature/home/cubit/home_cubit.dart';
import 'package:kheet_amal/feature/home/cubit/home_state.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import '../../../comments/cubits/comments_cubit/comments_cubit.dart';
import '../../../comments/cubits/comments_cubit/comments_state.dart';
import '../../data/models/report_model.dart';

class ReportActionBar extends StatelessWidget {
  const ReportActionBar({
    super.key,
    required this.actionChild,
    this.space,
    required this.report,
  });

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

          BlocBuilder<HomeCubit, HomeState>(
            builder: (context, state) {
              final currentReport = state.reports.firstWhere(
                (r) => r.id == report.id,
                orElse: () => report,
              );

              return GestureDetector(
                onTap: () {
                  context.read<HomeCubit>().toggleLike(report.id);
                },
                child: SvgPicture.asset(
                  currentReport.isLiked
                      ? 'assets/svgs/supported.svg'
                      : 'assets/svgs/support.svg',
                  height: 22.h,
                  width: 22.w,
                ),
              );
            },
          ),

          SizedBox(width: 5.w),

          // Likes count
          BlocBuilder<HomeCubit, HomeState>(
            builder: (context, state) {
              final currentReport = state.reports.firstWhere(
                (r) => r.id == report.id,
                orElse: () => report,
              );

              return Text(
                '${currentReport.likes}',
                style: TextStyle(fontSize: 16.sp),
              );
            },
          ),

          SizedBox(width: 25.w),

          // Comments button
          InkWell(
            onTap: () => PersistentNavBarNavigator.pushNewScreen(
              context,
              screen: BlocProvider(
                create: (context) =>
                    CommentsCubit()..commentCount(postId: report.id),
                child: CommentsPage(reportId: report.id),
              ),
              withNavBar: false,
            ),
            child: Image.asset(
              "assets/images/messages_icon.png",
              height: 20.h,
              width: 20.w,
            ),
          ),

          SizedBox(width: 5.w),

          BlocBuilder<CommentsCubit, CommentsState>(
            builder: (context, state) {
              if (state is CommentCountState) {
                int countComment = state.count;
                return Text("$countComment", style: TextStyle(fontSize: 16.sp));
              }
              return Text('0', style: TextStyle(fontSize: 16.sp));
            },
          ),

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
