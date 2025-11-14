// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'edit_screen.dart';
// import 'widgets/menu_item.dart';

// class ProfileScreen extends StatelessWidget {
//   const ProfileScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Padding(
//           padding: EdgeInsets.symmetric(horizontal: 16.w),
//           child: Column(
//             children: [
//               SizedBox(height: 20.h),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   GestureDetector(
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => const EditScreen(),
//                         ),
//                       );
//                     },
//                     child: Icon(Icons.edit, size: 20.sp),
//                   ),
//                   Text(
//                     'my_account'.tr(),
//                     style: TextStyle(
//                       fontSize: 20.sp,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   SizedBox(width: 20.w),
//                 ],
//               ),
//               SizedBox(height: 20.h),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.end,
//                     children: [
//                       Text(
//                         'بندق ساما',
//                         style: TextStyle(
//                           fontSize: 24.sp,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       Row(
//                         children: [
//                           Text(
//                             'القاهرة الجديدة',
//                             style: TextStyle(
//                               fontSize: 18.sp,
//                               color: Colors.grey,
//                             ),
//                           ),
//                           Icon(
//                             Icons.location_on_outlined,
//                             size: 18.sp,
//                             color: Colors.grey,
//                           ),
//                           SizedBox(width: 5.w),
//                         ],
//                       ),
//                     ],
//                   ),
//                   SizedBox(width: 10.w),
//                   CircleAvatar(radius: 40.r),
//                 ],
//               ),
//               SizedBox(height: 20.h),
//               Row(
//                 children: [
//                   Icon(Icons.phone, size: 18.sp, color: Colors.grey),
//                   SizedBox(width: 8.w),
//                   Text(
//                     '01011111111',
//                     style: TextStyle(fontSize: 18.sp, color: Colors.grey),
//                   ),
//                 ],
//               ),
//               SizedBox(height: 10.h),
//               Row(
//                 children: [
//                   Icon(Icons.email_outlined, size: 18.sp, color: Colors.grey),
//                   SizedBox(width: 8.w),
//                   Text(
//                     'bondoksama@gmail.com',
//                     style: TextStyle(fontSize: 18.sp, color: Colors.grey),
//                   ),
//                 ],
//               ),
//               Divider(height: 40.h),
//               MenuItem(
//                 title: 'saved'.tr(),
//                 icon: Icons.bookmark_border,
//                 count: 3,
//               ),
//               MenuItem(
//                 title: 'reports'.tr(),
//                 icon: Icons.edit_outlined,
//                 count: 1,
//               ),
//               MenuItem(title: 'language'.tr(), icon: Icons.language),
//               MenuItem(title: 'settings'.tr(), icon: Icons.settings),
//               MenuItem(
//                 title: 'logout'.tr(),
//                 icon: Icons.power_settings_new,
//                 iconColor: Colors.red,
//                 textColor: Colors.red,
//               ),
//               const Spacer(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:kheet_amal/core/routing/app_routes.dart';
import 'package:kheet_amal/feature/auth/cubit/auth_cubit.dart';
import 'package:kheet_amal/feature/my_reports_screen/my_reports_screen.dart';
import 'package:kheet_amal/feature/saved/saved_screen.dart';
import 'edit_screen.dart';
import 'widgets/menu_item.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    void changeLanguage() {
      if (context.locale == Locale('en')) {
        context.setLocale(Locale('ar'));
      } else {
        context.setLocale(Locale('en'));
      }
    }

    final authCubit = context.read<AuthCubit>();

    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
          future: authCubit.fetchUserData(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              print('Connection state: ${snapshot.connectionState}');
              print('Error: ${snapshot.error}');
              return Center(child: Text('Error: ${snapshot.error}'));
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              print('Connection state: ${snapshot.connectionState}');
              return const Center(child: CircularProgressIndicator());
            }

            if (!snapshot.hasData) {
              print('Connection state: ${snapshot.connectionState}');
              return Center(child: Text('No user data found'));
            }
            print(snapshot.data);
            print('Connection state: ${snapshot.connectionState}');
            final user = snapshot.data!;
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                children: [
                  SizedBox(height: 20.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditScreen(),
                            ),
                          );
                        },
                        child: Icon(Icons.edit, size: 20.sp),
                      ),
                      Text(
                        'my_account'.tr(),
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 20.w),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            user.name,
                            style: TextStyle(
                              fontSize: 24.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                user.address ?? 'Not specified',
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  color: Colors.grey,
                                ),
                              ),
                              Icon(
                                Icons.location_on_outlined,
                                size: 18.sp,
                                color: Colors.grey,
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(width: 10.w),
                      CircleAvatar(radius: 40.r),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  Row(
                    children: [
                      Icon(Icons.phone, size: 18.sp, color: Colors.grey),
                      SizedBox(width: 8.w),
                      Text(
                        user.phone,
                        style: TextStyle(fontSize: 18.sp, color: Colors.grey),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  Row(
                    children: [
                      Icon(
                        Icons.email_outlined,
                        size: 18.sp,
                        color: Colors.grey,
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        user.email,
                        style: TextStyle(fontSize: 18.sp, color: Colors.grey),
                      ),
                    ],
                  ),
                  Divider(height: 40.h),
                  MenuItem(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return SavedScreen();
                        },
                      ),
                    ),
                    title: 'saved'.tr(),
                    icon: Icons.bookmark_border,
                    count: 3,
                  ),
                  MenuItem(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return MyReports();
                        },
                      ),
                    ),
                    title: 'reports'.tr(),
                    icon: Icons.edit_outlined,
                    count: 1,
                  ),
                  MenuItem(
                    onTap: changeLanguage,
                    title: 'language'.tr(),
                    icon: Icons.language,
                  ),
                  MenuItem(title: 'settings'.tr(), icon: Icons.settings),
                  MenuItem(
                    onTap: () async {
                      await authCubit.logout();
                      Navigator.pushReplacementNamed(context, AppRoutes.login);
                    },
                    title: 'logout'.tr(),
                    icon: Icons.power_settings_new,
                    iconColor: Colors.red,
                    textColor: Colors.red,
                  ),
                  const Spacer(),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
