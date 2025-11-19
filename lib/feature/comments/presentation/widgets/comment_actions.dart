import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:kheet_amal/core/utils/app_colors.dart';
import '../../cubits/comments_cubit/comments_cubit.dart';
import '../../data/models/comment_model.dart';

class CommentActions extends StatelessWidget {
  final Comment comment;
  final String reportId;
  final VoidCallback onReplyTap;

  const CommentActions({
    super.key,
    required this.comment,
    required this.reportId,
      required this.onReplyTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Text('${comment.likes}', style: TextStyle(fontSize: 18.sp)),
            IconButton(
              onPressed: () {
                context.read<CommentsCubit>().toggleLike(
                  postId: reportId,
                  commentId: comment.id,
                );
              },
              icon: Icon(
                comment.isLiked ? Icons.favorite : Icons.favorite_border,
                size: 22.sp,
                color: comment.isLiked
                    ? AppColors.red
                    : AppColors.inactiveTrackbarColor,
              ),
            ),
          ],
        ),
        GestureDetector(
          onTap: onReplyTap,
          child: Text(
            'add_reply'.tr(),
            style: TextStyle(
              color: AppColors.inactiveTrackbarColor,
              fontSize: 18.sp,
            ),
          ),
        ),
      ],
    );
  }
}
