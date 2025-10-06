import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    required this.title,
    required this.notificationsCount,
  });

  final int notificationsCount;
  final String title;

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: TextStyle(fontWeight: FontWeight.w700, fontSize: 22.sp),
      ),
      centerTitle: true,
      elevation: 0,
      backgroundColor: const Color(0xFFF7F7F7),
      surfaceTintColor: const Color(0xFFF7F7F7),
      automaticallyImplyLeading: false,
      leadingWidth: 120.w,
      actions: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 2.w),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'statistics'.tr(),
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              IconButton(
                icon: SvgPicture.asset(
                  'assets/svgs/charts.svg',
                  width: 20.w,
                  height: 20.w,
                ),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ],
      leading: Stack(
        children: [
          IconButton(
            icon: Icon(
              Icons.notifications_none,
              size: 25.sp,
              color: Colors.black87,
            ),
            onPressed: () {},
          ),
          if (notificationsCount > 0)
            Positioned(
              left: 20.w,
              top: 4.h,
              child: Container(
                padding: EdgeInsets.all(3.w),
                decoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
                constraints: BoxConstraints(minWidth: 13.w, minHeight: 13.h),
                child: Text(
                  '$notificationsCount',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10.sp,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
