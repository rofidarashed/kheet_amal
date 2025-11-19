import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kheet_amal/core/utils/app_colors.dart';
import '../../cubits/comments_cubit/comments_cubit.dart';
import '../../cubits/comments_cubit/comments_state.dart';
import '../../data/models/comment_model.dart';
import '../../helpers/comment_helper.dart';
import '../widgets/app_bar_comment.dart';
import '../widgets/comment_input_field.dart';
import '../widgets/comment_item.dart';

class CommentsPage extends StatefulWidget {
  const CommentsPage({super.key, this.reportId});
  final String? reportId;
  @override
  State<CommentsPage> createState() => _CommentsPageState();
}

class _CommentsPageState extends State<CommentsPage> {
  TextEditingController controllerComment = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<CommentsCubit>().getComments(postId: widget.reportId!);
  }

  @override
  void dispose() {
    controllerComment.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CommentsCubit>();

    return BlocBuilder<CommentsCubit, CommentsState>(
      builder: (context, state) {
        List<Comment> comments = cubit.comments;

        if (state is CommentsGetSuccess) {
          comments = state.comments;
        }

        final bool showLoader =
            comments.isEmpty &&
            (state is CommentsGetLoading || state is CommentsStateLoading);

        return Scaffold(
          appBar: AppBarComment(countOfComment: comments.length.toString()),
          body: showLoader
              ? Center(child: CircularProgressIndicator())
              : Column(
                  children: [
                    Expanded(
                      child: ListView.separated(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 10.h,
                        ),
                        itemBuilder: (context, index) => CommentItem(
                          comment: comments[index],
                          onReport: (comment) {
                            CommentsHelpers.showReportSheet(
                              context: context,
                              comment: comment,
                              reportId: widget.reportId,
                              onSubmitted: () =>
                                  CommentsHelpers.showSuccessDialog(context),
                            );
                          },
                          reportId: widget.reportId!,
                        ),
                        separatorBuilder: (_, __) => Divider(
                          color: AppColors.hintTextColor,
                          height: 30.h,
                        ),
                        itemCount: comments.length,
                      ),
                    ),
                    CommentInputField(
                      controller: controllerComment,
                      onSend: () {
                        if (controllerComment.text.trim().isNotEmpty) {
                          context.read<CommentsCubit>().addComments(
                            postId: widget.reportId!,
                            text: controllerComment.text.trim(),
                          );
                          controllerComment.clear();
                        }
                      },
                    ),
                  ],
                ),
        );
      },
    );
  }
}
