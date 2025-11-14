import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kheet_amal/core/utils/app_colors.dart';
import '../models/comment_model.dart';
import 'package:easy_localization/easy_localization.dart';

class CommentItem extends StatefulWidget {
  final Comment comment;
  final Function(Comment) onReport;

  const CommentItem({Key? key, required this.comment, required this.onReport})
    : super(key: key);

  @override
  State<CommentItem> createState() => _CommentItemState();
}

class _CommentItemState extends State<CommentItem> {
  late Comment comment;

  @override
  void initState() {
    super.initState();
    comment = widget.comment;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  PopupMenuButton<int>(
                    icon: Icon(Icons.more_vert, size: 22.sp),
                    itemBuilder: (ctx) => [
                      PopupMenuItem(
                        value: 1,
                        child: Text(
                          'report'.tr(),
                          style: TextStyle(fontSize: 18.sp),
                        ),
                      ),
                    ],
                    onSelected: (value) {
                      if (value == 1) widget.onReport(comment);
                    },
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        comment.time,
                        style: TextStyle(
                          color: AppColors.inactiveTrackbarColor,
                          fontSize: 16.sp,
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        comment.name,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.sp,
                        ),
                      ),
                      SizedBox(width: 8.w),
                      CircleAvatar(
                        radius: 22.r,
                        child: Icon(
                          Icons.person,
                          color: AppColors.white,
                          size: 26.sp,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 6.h),
              Text(
                comment.text,
                textAlign: TextAlign.right,
                style: TextStyle(fontSize: 18.sp),
              ),
              SizedBox(height: 10.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        '${comment.likes}',
                        style: TextStyle(fontSize: 18.sp),
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            comment.isLiked = !comment.isLiked;
                            comment.likes += comment.isLiked ? 1 : -1;
                          });
                        },
                        icon: Icon(
                          comment.isLiked
                              ? Icons.favorite
                              : Icons.favorite_border,
                          size: 22.sp,
                          color: comment.isLiked
                              ? AppColors.red
                              : AppColors.inactiveTrackbarColor,
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Text(
                      'add_reply'.tr(),
                      style: TextStyle(
                        color: AppColors.inactiveTrackbarColor,
                        fontSize: 18.sp,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
