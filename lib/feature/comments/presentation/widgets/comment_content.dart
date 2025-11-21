import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../data/models/comment_model.dart';
import 'comment_actions.dart';
import 'comment_header.dart';

class CommentContent extends StatelessWidget {
  final Comment comment;
  final String reportId;
  final Function(Comment) onReport;
  final VoidCallback onReplyTap;

  const CommentContent({
    super.key,
    required this.comment,
    required this.reportId,
    required this.onReport,
    required this.onReplyTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  CommentHeader(
                    comment: comment,
                    onReport: () => onReport(comment),
                  ),
                  SizedBox(height: 6.h),
                  Text(
                    comment.text,
                    textAlign: TextAlign.right,
                    style: TextStyle(fontSize: 18.sp),
                  ),
                  SizedBox(height: 10.h),
                  CommentActions(
                    comment: comment,
                    reportId: reportId,
                    onReplyTap: onReplyTap,
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 12.h),
      ],
    );
  }
}
