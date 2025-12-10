import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:kheet_amal/feature/auth/cubit/auth_cubit.dart';
import 'package:kheet_amal/feature/auth/cubit/auth_state.dart';
import 'package:kheet_amal/feature/auth/presentation/screens/login_screen.dart';
import 'package:kheet_amal/feature/profile/data/models/user_model.dart';
import 'package:kheet_amal/feature/profile/widgets/profile_menu_section.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'edit_screen.dart';

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
              PersistentNavBarNavigator.pushNewScreen(
                context,
                screen: LoginScreen(),
                withNavBar: false,
                customPageRoute: MaterialPageRoute(
                  builder: (_) => LoginScreen(),
                ),
              );
            }
          },
          builder: (context, state) {
            // if (state is AuthLoading) {
            //   return const Center(child: CircularProgressIndicator());
            // }

            if (state is AuthFailure) {
              return Center(child: Text(state.error));
            }
            UserModel? user;

            if (state is AuthUserLoaded) {
              user = state.userModel;
            }
            final skeletonUser = UserModel(
              name: "",
              email: "",
              phone: "",
              address: "",
              profilePictureUrl: "",
              id: '',
            );

            final isLoading = state is AuthLoading || user == null;
            final displayUser = isLoading ? skeletonUser : user;
            return Skeletonizer(
              enabled: isLoading,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  children: [
                    SizedBox(height: 20.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: isLoading
                              ? null
                              : () async {
                                  final updated =
                                      await PersistentNavBarNavigator.pushNewScreen(
                                        context,
                                        screen: EditScreen(user: displayUser),
                                        withNavBar: false,
                                      );

                                  if (updated == true) {
                                    authCubit.fetchUserData();
                                  }
                                },
                        ),
                        Text(
                          'my_account'.tr(),
                          style: TextStyle(
                            fontSize: 28.sp,
                            fontWeight: FontWeight.w700,
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
                              displayUser.name.isEmpty
                                  ? "••••••••"
                                  : displayUser.name,
                              style: TextStyle(
                                fontSize: 24.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  displayUser.address?.isNotEmpty == true
                                      ? displayUser.address!
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
                              (displayUser.profilePictureUrl?.isNotEmpty ??
                                  false)
                              ? NetworkImage(displayUser.profilePictureUrl!)
                              : null,
                          child:
                              (displayUser.profilePictureUrl == null ||
                                  displayUser.profilePictureUrl!.isEmpty)
                              ? Icon(
                                  Icons.person,
                                  size: 40.sp,
                                  color: Colors.grey,
                                )
                              : null,
                        ),
                      ],
                    ),

                    SizedBox(height: 20.h),

                    Row(
                      children: [
                        Icon(Icons.phone, size: 18.sp, color: Colors.grey),
                        SizedBox(width: 8.w),
                        Text(
                          displayUser.phone,
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
                          displayUser.email,
                          style: TextStyle(fontSize: 18.sp, color: Colors.grey),
                        ),
                      ],
                    ),
                    Divider(height: 40.h),

                    if (!isLoading) ProfileMenuSection(authCubit: authCubit),

                    const Spacer(),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
