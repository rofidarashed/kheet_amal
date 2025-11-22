//
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:kheet_amal/core/utils/app_colors.dart';
// import 'package:easy_localization/easy_localization.dart';
//
// import '../../cubits/comments_cubit/comments_cubit.dart';
// import '../../cubits/comments_cubit/comments_state.dart';
// import '../../data/models/comment_model.dart';
//
// class CommentItem extends StatefulWidget {
//   final Comment comment;
//   final reportId;
//   final Function(Comment) onReport;
//
//   const CommentItem({
//     Key? key,
//     required this.comment,
//     required this.onReport,
//     required this.reportId,
//   }) : super(key: key);
//
//   @override
//   State<CommentItem> createState() => _CommentItemState();
// }
//
// class _CommentItemState extends State<CommentItem> {
//   bool showReplyField = false;
//   TextEditingController replyController = TextEditingController();
//   bool isLoadingReplies = false;
//
//   @override
//   void dispose() {
//     replyController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final comment = widget.comment;
//
//     return BlocListener<CommentsCubit, CommentsState>(
//       listener: (context, state) {
//         if (state is ReplyStateSuccess) {
//           replyController.clear();
//           setState(() {
//             showReplyField = false;
//           });
//         } else if (state is ReplyStateError) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(content: Text(state.message)),
//           );
//         } else if (state is RepliesGetError) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(content: Text(state.message)),
//           );
//         }
//       },
//       child: BlocBuilder<CommentsCubit, CommentsState>(
//         builder: (context, state) {
//           final cubit = context.read<CommentsCubit>();
//           final latestComment = cubit.comments.firstWhere(
//                 (c) => c.id == comment.id,
//             orElse: () => comment,
//           );
//
//           return Column(
//             crossAxisAlignment: CrossAxisAlignment.end,
//             children: [
//               _buildCommentUI(latestComment),
//
//               if (showReplyField) _buildReplyInput(latestComment),
//
//               if (isLoadingReplies)
//                 Padding(
//                   padding: EdgeInsets.only(right: 40.w, top: 10.h),
//                   child: Center(
//                     child: SizedBox(
//                       width: 20.w,
//                       height: 20.h,
//                       child: CircularProgressIndicator(strokeWidth: 2),
//                     ),
//                   ),
//                 ),
//               if (latestComment.replies.isNotEmpty && !isLoadingReplies)
//                 Padding(
//                   padding: EdgeInsets.only(right: 40.w, top: 10.h),
//                   child: Column(
//                     children: latestComment.replies.map((r) {
//                       return _buildReplyUI(r, latestComment.id);
//                     }).toList(),
//                   ),
//                 ),
//             ],
//           );
//         },
//       ),
//     );
//   }
//
//   Widget _buildCommentUI(Comment c) {
//     return Column(
//       children: [
//         Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.end,
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       PopupMenuButton<int>(
//                         icon: Icon(Icons.more_vert, size: 22.sp),
//                         itemBuilder: (ctx) => [
//                           PopupMenuItem(
//                             value: 1,
//                             child: Text(
//                               'report'.tr(),
//                               style: TextStyle(fontSize: 18.sp),
//                             ),
//                           ),
//                         ],
//                         onSelected: (value) {
//                           if (value == 1) widget.onReport(c);
//                         },
//                       ),
//                       Row(
//                         children: [
//                           Text(
//                             c.time,
//                             style: TextStyle(
//                               color: AppColors.inactiveTrackbarColor,
//                               fontSize: 16.sp,
//                             ),
//                           ),
//                           SizedBox(width: 8.w),
//                           Text(
//                             c.name,
//                             style: TextStyle(
//                               fontWeight: FontWeight.bold,
//                               fontSize: 20.sp,
//                             ),
//                           ),
//                           SizedBox(width: 8.w),
//                           CircleAvatar(
//                             radius: 22.r,
//                             child: Icon(
//                               Icons.person,
//                               color: AppColors.white,
//                               size: 26.sp,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 6.h),
//                   Text(
//                     c.text,
//                     textAlign: TextAlign.right,
//                     style: TextStyle(fontSize: 18.sp),
//                   ),
//                   SizedBox(height: 10.h),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Row(
//                         children: [
//                           Text(
//                             '${c.likes}',
//                             style: TextStyle(fontSize: 18.sp),
//                           ),
//                           IconButton(
//                             onPressed: () {
//                               // Let the cubit handle all the state updates
//                               context.read<CommentsCubit>().toggleLike(
//                                 postId: widget.reportId,
//                                 commentId: c.id,
//                               );
//                             },
//                             icon: Icon(
//                               c.isLiked
//                                   ? Icons.favorite
//                                   : Icons.favorite_border,
//                               size: 22.sp,
//                               color: c.isLiked
//                                   ? AppColors.red
//                                   : AppColors.inactiveTrackbarColor,
//                             ),
//                           ),
//                         ],
//                       ),
//                       GestureDetector(
//                         onTap: () {
//                           setState(() {
//                             showReplyField = !showReplyField;
//                           });
//                         },
//                         child: Text(
//                           'add_reply'.tr(),
//                           style: TextStyle(
//                             color: AppColors.inactiveTrackbarColor,
//                             fontSize: 18.sp,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//         SizedBox(height: 12.h),
//       ],
//     );
//   }
//
//   Widget _buildReplyInput(Comment comment) {
//     return Padding(
//       padding: EdgeInsets.only(right: 40.w, bottom: 10.h),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.end,
//         children: [
//           Container(
//             padding: EdgeInsets.all(12.w),
//             decoration: BoxDecoration(
//               color: AppColors.inactiveTrackbarColor.withOpacity(0.1),
//               borderRadius: BorderRadius.circular(10.r),
//             ),
//             child: TextField(
//               controller: replyController,
//               textAlign: TextAlign.right,
//               keyboardType: TextInputType.multiline,
//               maxLines: null,
//               decoration: InputDecoration(
//                 hintText: 'write_reply_here'.tr(),
//                 border: InputBorder.none,
//                 hintStyle: TextStyle(
//                   color: AppColors.inactiveTrackbarColor,
//                   fontSize: 16.sp,
//                 ),
//               ),
//               style: TextStyle(fontSize: 18.sp),
//             ),
//           ),
//           SizedBox(height: 6.h),
//           Align(
//             alignment: Alignment.centerLeft,
//             child: ElevatedButton(
//               onPressed: () {
//                 if (replyController.text.trim().isNotEmpty) {
//                   context.read<CommentsCubit>().replyToComment(
//                     postId: widget.reportId,
//                     commentId: comment.id,
//                     text: replyController.text.trim(),
//                   );
//                 }
//               },
//               child: Text("إرسال"),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildReplyUI(Comment reply, String parentCommentId) {
//     return Container(
//       margin: EdgeInsets.only(bottom: 10.h),
//       padding: EdgeInsets.all(10.w),
//       decoration: BoxDecoration(
//         color: AppColors.inactiveTrackbarColor.withOpacity(0.07),
//         borderRadius: BorderRadius.circular(8.r),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.end,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               PopupMenuButton<int>(
//                 icon: Icon(Icons.more_vert, size: 20.sp),
//                 itemBuilder: (ctx) => [
//                   PopupMenuItem(
//                     value: 1,
//                     child: Text(
//                       'report'.tr(),
//                       style: TextStyle(fontSize: 16.sp),
//                     ),
//                   ),
//                 ],
//                 onSelected: (value) {
//                   if (value == 1) {
//                     widget.onReport(reply);
//                   }
//                 },
//               ),
//               Row(
//                 children: [
//                   Text(
//                     reply.time,
//                     style: TextStyle(
//                       color: AppColors.inactiveTrackbarColor,
//                       fontSize: 14.sp,
//                     ),
//                   ),
//                   SizedBox(width: 6.w),
//                   Text(
//                     reply.name,
//                     style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                       fontSize: 16.sp,
//                     ),
//                   ),
//                   SizedBox(width: 8.w),
//                   CircleAvatar(
//                     radius: 16.r,
//                     child: Icon(
//                       Icons.person,
//                       size: 18.sp,
//                       color: AppColors.white,
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//           SizedBox(height: 6.h),
//           Text(
//             reply.text,
//             textAlign: TextAlign.right,
//             style: TextStyle(fontSize: 16.sp),
//           ),
//           SizedBox(height: 6.h),
//           Row(
//             children: [
//               Text('${reply.likes}', style: TextStyle(fontSize: 16.sp)),
//               IconButton(
//                 padding: EdgeInsets.zero,
//                 constraints: BoxConstraints(),
//                 onPressed: () {
//                   // Call the toggleReplyLike method with parent comment ID
//                   context.read<CommentsCubit>().toggleReplyLike(
//                     postId: widget.reportId,
//                     commentId: parentCommentId,
//                     replyId: reply.id,
//                   );
//                 },
//                 icon: Icon(
//                   reply.isLiked ? Icons.favorite : Icons.favorite_border,
//                   size: 18.sp,
//                   color: reply.isLiked
//                       ? AppColors.red
//                       : AppColors.inactiveTrackbarColor,
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kheet_amal/feature/comments/presentation/widgets/comment_content.dart';
import 'package:kheet_amal/feature/comments/presentation/widgets/reply_input_field.dart';
import 'package:kheet_amal/feature/comments/presentation/widgets/reply_list.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../cubits/comments_cubit/comments_cubit.dart';
import '../../cubits/comments_cubit/comments_state.dart';
import '../../data/models/comment_model.dart';

class CommentItem extends StatefulWidget {
  final Comment comment;
  final String reportId;
  final Function(Comment) onReport;

  const CommentItem({
    super.key,
    required this.comment,
    required this.onReport,
    required this.reportId,
  });

  @override
  State<CommentItem> createState() => _CommentItemState();
}

class _CommentItemState extends State<CommentItem> {
  bool showReplyField = false;
  final TextEditingController replyController = TextEditingController();
  bool isLoadingReplies = false;

  @override
  void dispose() {
    replyController.dispose();
    super.dispose();
  }

  void _toggleReplyField() {
    setState(() {
      showReplyField = !showReplyField;
    });
  }

  void _handleReplySubmit() {
    if (replyController.text.trim().isNotEmpty) {
      context.read<CommentsCubit>().replyToComment(
        postId: widget.reportId,
        commentId: widget.comment.id,
        text: replyController.text.trim(),
      );
    }
  }

  void _handleReplySuccess() {
    replyController.clear();
    setState(() {
      showReplyField = false;
    });
  }

  void _showErrorMessage(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CommentsCubit, CommentsState>(
      listener: (context, state) {
        if (state is ReplyStateSuccess) {
          _handleReplySuccess();
        } else if (state is ReplyStateError) {
          _showErrorMessage(state.message);
        } else if (state is RepliesGetError) {
          _showErrorMessage(state.message);
        }
      },
      child: BlocBuilder<CommentsCubit, CommentsState>(
        builder: (context, state) {
          final cubit = context.read<CommentsCubit>();
          final latestComment = cubit.comments.firstWhere(
            (c) => c.id == widget.comment.id,
            orElse: () => widget.comment,
          );

          return Skeletonizer(
            enabled:
                state is CommentsStateLoading || state is ReplyStateLoading,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                CommentContent(
                  comment: latestComment,
                  reportId: widget.reportId,
                  onReport: widget.onReport,
                  onReplyTap: _toggleReplyField,
                ),
                if (showReplyField)
                  ReplyInputField(
                    controller: replyController,
                    onSubmit: _handleReplySubmit,
                  ),
                if (isLoadingReplies)
                  Padding(
                    padding: EdgeInsets.only(right: 40.w, top: 10.h),
                    child: Center(
                      child: SizedBox(
                        width: 20.w,
                        height: 20.h,
                        child: const CircularProgressIndicator(strokeWidth: 2),
                      ),
                    ),
                  ),
                if (latestComment.replies.isNotEmpty && !isLoadingReplies)
                  ReplyList(
                    replies: latestComment.replies,
                    parentCommentId: latestComment.id,
                    reportId: widget.reportId,
                    onReport: widget.onReport,
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
