import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:kheet_amal/core/utils/app_colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubits/comments_cubit/comments_cubit.dart';
import '../data/models/comment_model.dart';
import '../presentation/widgets/report_sheet.dart';

class CommentsHelpers {
  static void showReportSheet({
    required BuildContext context,
    required Comment comment,
    required dynamic reportId,
    required VoidCallback onSubmitted,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (ctx) => BlocProvider.value(
        value: context.read<CommentsCubit>(),
        child: ReportSheet(
          onSubmitted: (reason, details) {
            Navigator.of(ctx).pop();
            onSubmitted();
          },
          postId: reportId,
          commentId: comment.id,
        ),
      ),
    );
  }

  static void showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) {
        Future.delayed(const Duration(seconds: 2), () {
          Navigator.of(ctx).pop();
        });

        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.check_circle, size: 84.sp, color: AppColors.green),
              SizedBox(height: 12.h),
              Text(
                'report_success'.tr(),
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.sp),
              ),
              SizedBox(height: 8.h),
              Text(
                'report_received'.tr(),
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18.sp),
              ),
            ],
          ),
        );
      },
    );
  }
}
