import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kheet_amal/core/utils/app_colors.dart';
import 'package:kheet_amal/feature/notification/widgets/dummy_notifications.dart';
import 'package:kheet_amal/feature/notification/widgets/no_notifications_view.dart';
import 'package:kheet_amal/feature/notification/widgets/notification_card.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  bool notificationsEnabled = true;

  @override
  Widget build(BuildContext context) {
    final bool hasNotifications = notifications.isNotEmpty;

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
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
              child: Switch(
                value: notificationsEnabled,
                activeColor: AppColors.primaryColor,
                onChanged: (value) {
                  setState(() {
                    notificationsEnabled = value;
                  });
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
      ),
      body: hasNotifications
          ? ListView.builder(
              padding: EdgeInsets.all(12.w),
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                final item = notifications[index];
                return Align(
                  alignment: Alignment.centerRight,
                  child: NotificationCard(
                    title: item['title'],
                    message: item['message'],
                    time: item['time'],
                    icon: item['icon'],
                    color: item['color'],
                  ),
                );
              },
            )
          : const NoNotificationsView(),
    );
  }
}
