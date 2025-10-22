import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReportActionBar extends StatelessWidget {
  const ReportActionBar({
    super.key,
    required this.onPressed,
    required this.actionChild,
    this.space,
  });
  final VoidCallback onPressed;
  final Widget actionChild;
  final double? space;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(width: space ?? 0),
          InkWell(
            onTap: () {},
            child: Image.asset(
              "assets/images/heart_icon.png",
              height: 20.h,
              width: 20.w,
            ),
          ),
          SizedBox(width: 5.w),
          Text('20', style: TextStyle(fontSize: 16.sp)),
          SizedBox(width: 25.w),
          InkWell(
            onTap: () {},
            child: Image.asset(
              "assets/images/messages_icon.png",
              height: 20.h,
              width: 20.w,
            ),
          ),
          SizedBox(width: 5.w),
          Text('20', style: TextStyle(fontSize: 16.sp)),
          Spacer(),
          Padding(
            padding: EdgeInsets.fromLTRB(0, 0.h, 8.w, 0.h),
            child: actionChild,
          ),
        ],
      ),
    );
  }
}
