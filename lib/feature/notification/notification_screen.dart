import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kheet_amal/core/utils/app_colors.dart';
import 'package:kheet_amal/feature/notification/cubit/notification_cubit.dart';
import 'package:kheet_amal/feature/notification/cubit/notification_state.dart';
import 'package:kheet_amal/feature/notification/widgets/no_notifications_view.dart';
import 'package:kheet_amal/feature/notification/widgets/notification_card.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NotificationCubit()..initNotifications(),
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: _buildAppBar(context),
        body: BlocBuilder<NotificationCubit, NotificationState>(
          builder: (context, state) {
            if (state is NotificationLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is NotificationError) {
              return Center(child: Text(state.message));
            }

            if (state is NotificationLoaded) {
              if (!state.isEnabled) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.notifications_off,
                        size: 60.sp,
                        color: Colors.grey,
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        "Notifications are disabled",
                        style: TextStyle(fontSize: 18.sp),
                      ),
                    ],
                  ),
                );
              }

              if (state.notifications.isEmpty) {
                return const NoNotificationsView();
              }

              return ListView.builder(
                padding: EdgeInsets.all(12.w),
                itemCount: state.notifications.length,
                itemBuilder: (context, index) {
                  final item = state.notifications[index];
                  final timeStr = DateFormat('hh:mm a').format(item.time);
                  debugPrint(
                    'Rendering notification: ${item.title} at $timeStr',
                  );
                  return Align(
                    alignment: Alignment.centerRight,
                    child: NotificationCard(
                      title: item.title,
                      message: item.message,
                      time: timeStr,
                      icon: item.icon,
                      color: item.color,
                    ),
                  );
                },
              );
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      leadingWidth: 60.w,
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios, color: Colors.black, size: 20.sp),
        onPressed: () => Navigator.pop(context),
      ),
      actions: [
        Padding(
          padding: EdgeInsets.only(left: 8.w),
          child: Align(
            alignment: Alignment.centerRight,
            child: BlocBuilder<NotificationCubit, NotificationState>(
              builder: (context, state) {
                bool isEnabled = true;
                if (state is NotificationLoaded) isEnabled = state.isEnabled;

                return Switch(
                  value: isEnabled,
                  activeColor: AppColors.primaryColor,
                  onChanged: (value) {
                    context.read<NotificationCubit>().toggleNotifications(
                      value,
                    );
                  },
                );
              },
            ),
          ),
        ),
      ],
      centerTitle: true,
      title: Text(
        'notifications'.tr(),
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 22.sp,
        ),
      ),
    );
  }
}
