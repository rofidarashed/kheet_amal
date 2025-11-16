import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kheet_amal/core/utils/app_colors.dart';
import 'package:kheet_amal/feature/comments/models/comment_model.dart';
import 'package:kheet_amal/feature/comments/widgets/comment_item.dart';
import 'package:kheet_amal/feature/comments/widgets/report_sheet.dart';

class CommentsPage extends StatefulWidget {
  const CommentsPage({Key? key}) : super(key: key);

  @override
  State<CommentsPage> createState() => _CommentsPageState();
}

class _CommentsPageState extends State<CommentsPage> {
  final List<Comment> comments = List.generate(
    3,
    (i) => Comment(
      name: i == 2 ? 'منال احمد' : 'سعد محمد',
      time: 'منذ 10 دقائق',
      text:
          'شفت طفل بنفس المواصفات تقريباً عند محطة الباص في شارع التسعين، كان مع شخص غريب.',
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.close, color: AppColors.black, size: 26.sp),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
              decoration: BoxDecoration(
                color: AppColors.secondaryColor.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Text(
                '${comments.length}',
                style: TextStyle(color: AppColors.black, fontSize: 18.sp),
              ),
            ),
            SizedBox(width: 8.w),
            Text(
              'comments'.tr(),
              style: TextStyle(color: AppColors.black, fontSize: 24.sp),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
              itemBuilder: (context, index) => CommentItem(
                comment: comments[index],
                onReport: _showReportSheet,
              ),
              separatorBuilder: (_, __) =>
                  Divider(color: AppColors.border, height: 30.h),
              itemCount: comments.length,
            ),
          ),
          _buildInputField(),
        ],
      ),
    );
  }

  Widget _buildInputField() {
    return SafeArea(
      top: false,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        child: TextField(
          textAlign: TextAlign.right,
          decoration: InputDecoration(
            hintText: 'write_comment'.tr(),
            hintStyle: TextStyle(fontSize: 18.sp),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.r),
              borderSide: BorderSide(color: AppColors.inactiveTrackbarColor),
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: 12.h,
            ),
            prefixIcon: Padding(
              padding: EdgeInsets.only(left: 8.w, right: 4.w),
              child: CircleAvatar(
                radius: 18.r,
                backgroundColor: AppColors.secondaryColor,
                child: Icon(
                  Icons.arrow_back,
                  color: AppColors.white,
                  size: 20.sp,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showReportSheet(Comment comment) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (ctx) => ReportSheet(
        onSubmitted: (reason, details) {
          Navigator.of(ctx).pop();
          _showSuccessDialog();
        },
      ),
    );
  }

  void _showSuccessDialog() {
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
