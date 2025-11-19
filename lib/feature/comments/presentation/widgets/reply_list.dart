
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kheet_amal/feature/comments/presentation/widgets/reply_item.dart';

import '../../data/models/comment_model.dart';



class ReplyList extends StatelessWidget {
  final List<Comment> replies;
  final String parentCommentId;
  final String reportId;
  final Function(Comment) onReport;

  const ReplyList({
    super.key,
    required this.replies,
    required this.parentCommentId,
    required this.reportId,
    required this.onReport,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 40.w, top: 10.h),
      child: Column(
        children: replies.map((reply) {
          return ReplyItem(
            reply: reply,
            parentCommentId: parentCommentId,
            reportId: reportId,
            onReport: onReport,
          );
        }).toList(),
      ),
    );
  }
}