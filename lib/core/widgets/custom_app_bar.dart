import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kheet_amal/core/routing/app_routes.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:kheet_amal/core/utils/app_colors.dart';
import 'package:kheet_amal/core/utils/app_icons.dart';
import 'package:kheet_amal/feature/notification/cubit/notification_cubit.dart';
import 'package:kheet_amal/feature/notification/cubit/notification_state.dart';
import 'package:kheet_amal/feature/statistics/screens/statistics_screen.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key, required this.title});

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
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return StatisticsScreen();
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ],
      leading: BlocBuilder<NotificationCubit, NotificationState>(
        builder: (context, state) {
          int notificationsCount = 0;

          if (state is NotificationLoaded) {
            notificationsCount = state.notifications
                .where((n) => !n.isRead)
                .length;
          }

          return Stack(
            children: [
              IconButton(
                icon: SvgPicture.asset(
                  AppIcons.bellNotification,
                  width: 24.w,
                  height: 24.w,
                ),
                onPressed: () {
                  Navigator.of(
                    context,
                    rootNavigator: true,
                  ).pushNamed(AppRoutes.notifications);
                },
              ),
              if (notificationsCount > 0)
                Positioned(
                  left: 30.w,
                  top: 9.h,
                  child: Container(
                    padding: EdgeInsets.all(3.w),
                    decoration: const BoxDecoration(
                      color: AppColors.iconRed,
                      shape: BoxShape.circle,
                    ),
                    constraints: BoxConstraints(
                      minWidth: 12.w,
                      minHeight: 12.h,
                    ),
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
          );
        },
      ),
    );
  }
}
