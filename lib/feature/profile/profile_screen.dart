
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:kheet_amal/core/routing/app_routes.dart';
import 'package:kheet_amal/core/utils/app_colors.dart';
import 'package:kheet_amal/feature/auth/cubit/auth_cubit.dart';
import 'package:kheet_amal/feature/auth/cubit/auth_state.dart';
import 'package:kheet_amal/feature/profile/widgets/change_lang.dart';
import 'package:kheet_amal/feature/profile/widgets/profile_menue_section.dart';
import 'edit_screen.dart';
import 'widgets/menu_item.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authCubit = context.read<AuthCubit>();

    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is AuthLoggedOut) {
              Navigator.of(context).pushNamedAndRemoveUntil(
                AppRoutes.login,
                (route) => false,
              );
            }
          },
          builder: (context, state) {
            if (state is AuthLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is AuthFailure) {
              return Center(
                child: Text(state.error),
              );
            }

            if (state is AuthUserLoaded) {
              final user = state.userModel;

              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  children: [
                    SizedBox(height: 20.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () async {
                            final updated = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => EditScreen(user: user),
                              ),
                            );

                            if (updated == true) {
                              authCubit.fetchUserData(); 
                            }
                          },
                        ),
                        Text(
                          'my_account'.tr(),
                          style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 30), 
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
                                  user.address?.isNotEmpty == true
                                      ? user.address!
                                      : 'Not specified',
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
                        CircleAvatar(
                          radius: 40.r,
                          backgroundColor: Colors.grey[300],
                          backgroundImage:
                              (user.profilePictureUrl?.isNotEmpty ?? false)
                                  ? NetworkImage(user.profilePictureUrl!)
                                  : null,
                          child: (user.profilePictureUrl == null ||
                                  user.profilePictureUrl!.isEmpty)
                              ? Icon(Icons.person,
                                  size: 40.sp, color: Colors.grey)
                              : null,
                        ),
                      ],
                    ),

                    SizedBox(height: 20.h),

                
                    Row(
                      children: [
                        Icon(Icons.phone, size: 18.sp, color: Colors.grey),
                        SizedBox(width: 8.w),
                        Text(user.phone,
                            style: TextStyle(
                                fontSize: 18.sp, color: Colors.grey)),
                      ],
                    ),
                    SizedBox(height: 10.h),
                    Row(
                      children: [
                        Icon(Icons.email_outlined,
                            size: 18.sp, color: Colors.grey),
                        SizedBox(width: 8.w),
                        Text(user.email,
                            style: TextStyle(
                                fontSize: 18.sp, color: Colors.grey)),
                      ],
                    ),

                    Divider(height: 40.h),

                  ProfileMenuSection(authCubit: authCubit),

                    const Spacer(),
                  ],
                ),
              );
            }

            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
