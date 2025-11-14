import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kheet_amal/core/utils/app_colors.dart';
import 'package:easy_localization/easy_localization.dart';

class ReportSheet extends StatefulWidget {
  final void Function(String reason, String details) onSubmitted;
  const ReportSheet({Key? key, required this.onSubmitted}) : super(key: key);

  @override
  State<ReportSheet> createState() => _ReportSheetState();
}

class _ReportSheetState extends State<ReportSheet> {
  String _reason = '';
  final TextEditingController _otherController = TextEditingController();
  final TextEditingController _detailsController = TextEditingController();

  @override
  void dispose() {
    _otherController.dispose();
    _detailsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 18.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(width: 8.w),
                Text(
                  'report_comment'.tr(),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22.sp,
                  ),
                ),
                Icon(
                  Icons.warning_amber_rounded,
                  color: AppColors.secondaryColor,
                  size: 28.sp,
                ),
              ],
            ),
            SizedBox(height: 10.h),
            Text(
              'help_us_keep_safe'.tr(),
              style: TextStyle(fontSize: 18.sp),
              textAlign: TextAlign.right,
            ),
            SizedBox(height: 12.h),
            ..._buildRadioOptions(),
            SizedBox(height: 12.h),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                'add_more_details'.tr(),
                style: TextStyle(
                  color: AppColors.black,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 8.h),
            TextField(
              controller: _detailsController,
              textAlign: TextAlign.right,
              minLines: 1,
              maxLines: 5,
              style: TextStyle(fontSize: 18.sp),
              decoration: InputDecoration(
                hintText: 'extra_details_hint'.tr(),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
            ),
            SizedBox(height: 22.h),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.secondaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.r),
                  ),
                  padding: EdgeInsets.symmetric(
                    vertical: 12.h,
                    horizontal: 80.w,
                  ),
                ),
                onPressed: () {
                  final reason = _reason == 'other'.tr()
                      ? _otherController.text
                      : _reason;
                  widget.onSubmitted(reason, _detailsController.text);
                },
                child: Text(
                  'send_report'.tr(),
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildRadioOptions() {
    final options = [
      'contains_offensive'.tr(),
      'misleading_info'.tr(),
      'inappropriate_content'.tr(),
      'fraud_or_ads'.tr(),
      'other'.tr(),
    ];

    return options.map((opt) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          RadioListTile<String>(
            value: opt,
            groupValue: _reason,
            onChanged: (v) => setState(() => _reason = v ?? ''),
            controlAffinity: ListTileControlAffinity.trailing,
            title: Align(
              alignment: Alignment.centerRight,
              child: Text(opt, textAlign: TextAlign.right),
            ),
          ),
          if (opt == 'other'.tr() && _reason == 'other'.tr())
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: TextField(
                controller: _otherController,
                textAlign: TextAlign.right,
                decoration: InputDecoration(
                  hintText: 'please_explain_reason'.tr(),
                ),
              ),
            ),
        ],
      );
    }).toList();
  }
}
