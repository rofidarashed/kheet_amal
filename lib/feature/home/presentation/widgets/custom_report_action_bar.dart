import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kheet_amal/feature/comments/presentation/screen/comments_screen.dart';
import '../../../comments/cubits/comments_cubit/comments_cubit.dart';
import '../../../comments/cubits/comments_cubit/comments_state.dart';
import '../../../support_reports/cubits/sup_reports_cubit/supprot_reports_cubit.dart';
import '../../../support_reports/cubits/sup_reports_cubit/supprot_reports_state.dart';
import '../../data/models/report_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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

          BlocBuilder<SupportReportsCubit, SupportReportsState>(
            builder: (context, state) {
              bool isSupported = false;
              if (state is SupportReportsToggled &&
                  state.reportId == report.id) {
                isSupported = state.isSupported;
              }

              return FutureBuilder<bool>(
                future: _alreadyLikedFromFirestore(report.id),
                builder: (context, snapshot) {
                  bool alreadyLiked = snapshot.data ?? false;

                  return GestureDetector(
                    onTap: () {
                      context
                          .read<SupportReportsCubit>()
                          .toggleSupport(report.id);
                    },
                    child: SvgPicture.asset(
                      // الأيقونة تظل حمراء إذا المستخدم دعم التقرير سابقًا
                      isSupported || alreadyLiked
                          ? 'assets/svgs/supported.svg'
                          : 'assets/svgs/support.svg',
                      height: 22.h,
                      width: 22.w,
                    ),
                  );
                },
              );
            },
          ),

          SizedBox(width: 5.w),

          StreamBuilder<DocumentSnapshot>(
            stream: FirebaseFirestore.instance
                .collection('reports')
                .doc(report.id)
                .snapshots(),
            builder: (context, snapshot) {
              int likes = 0;
              if (snapshot.hasData && snapshot.data!.exists) {
                final data = snapshot.data!.data() as Map<String, dynamic>?;
                final dynamic count = data?['likesCount'];
                if (count is int) {
                  likes = count;
                } else if (count is num) {
                  likes = count.toInt();
                } else {
                  likes = 0;
                }
              }
              return Text('$likes', style: TextStyle(fontSize: 16.sp));
            },
          ),

          SizedBox(width: 25.w),
          InkWell(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => BlocProvider(
                  create: (context) =>
                      CommentsCubit()..commentCount(postId: report.id),
                  child: CommentsPage(reportId: report.id),
                ),
              ),
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
                log("$countComment");
                return Text("$countComment", style: TextStyle(fontSize: 16.sp));
              }
              return Text('0');
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


  Future<bool> _alreadyLikedFromFirestore(String reportId) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return false;

    final doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('support_reports')
        .doc(reportId)
        .get();

    return doc.exists;
  }
}
