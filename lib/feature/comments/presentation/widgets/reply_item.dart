import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:kheet_amal/core/utils/app_colors.dart';


import '../../cubits/comments_cubit/comments_cubit.dart';
import '../../data/models/comment_model.dart';

class ReplyItem extends StatelessWidget {
  final Comment reply;
  final String parentCommentId;
  final String reportId;
  final Function(Comment) onReport;

  const ReplyItem({
    super.key,
    required this.reply,
    required this.parentCommentId,
    required this.reportId,
    required this.onReport,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.h),
      padding: EdgeInsets.all(10.w),
      decoration: BoxDecoration(
        color: AppColors.inactiveTrackbarColor.withOpacity(0.07),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              PopupMenuButton<int>(
                icon: Icon(Icons.more_vert, size: 20.sp),
                itemBuilder: (ctx) => [
                  PopupMenuItem(
                    value: 1,
                    child: Text(
                      'report'.tr(),
                      style: TextStyle(fontSize: 16.sp),
                    ),
                  ),
                ],
                onSelected: (value) {
                  if (value == 1) onReport(reply);
                },
              ),
              Row(
                children: [
                  Text(
                    reply.time,
                    style: TextStyle(
                      color: AppColors.inactiveTrackbarColor,
                      fontSize: 14.sp,
                    ),
                  ),
                  SizedBox(width: 6.w),
                  Text(
                    reply.name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.sp,
                    ),
                  ),
                  SizedBox(width: 8.w),
                  CircleAvatar(
                    radius: 16.r,
                    child: Icon(
                      Icons.person,
                      size: 18.sp,
                      color: AppColors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 6.h),
          Text(
            reply.text,
            textAlign: TextAlign.right,
            style: TextStyle(fontSize: 16.sp),
          ),
          SizedBox(height: 6.h),
          Row(
            children: [
              Text('${reply.likes}', style: TextStyle(fontSize: 16.sp)),
              IconButton(
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                onPressed: () {
                  context.read<CommentsCubit>().toggleReplyLike(
                    postId: reportId,
                    commentId: parentCommentId,
                    replyId: reply.id,
                  );
                },
                icon: Icon(
                  reply.isLiked ? Icons.favorite : Icons.favorite_border,
                  size: 18.sp,
                  color: reply.isLiked
                      ? AppColors.red
                      : AppColors.inactiveTrackbarColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}