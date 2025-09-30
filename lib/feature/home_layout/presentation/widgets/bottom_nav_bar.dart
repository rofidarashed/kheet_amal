import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kheet_amal/core/utils/app_icons.dart';
import 'package:kheet_amal/feature/add_report/presentation/screen/add_report_screen.dart';
import 'package:kheet_amal/feature/profile/profile_screan.dart';
import 'package:kheet_amal/feature/search/search_screan.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import '../../../../core/utils/app_colors.dart';
import 'package:kheet_amal/feature/home/home_screen.dart';
import '../cubit/bottom_nav_cubit.dart';
import '../cubit/bottom_nav_state.dart';

class BottomNavBar extends StatelessWidget {
  final PersistentTabController controller;

  const BottomNavBar({super.key, required this.controller});

  List<Widget> _screens() {
    return [HomeScreen(), SearchScrean(), AddReportScreen(), ProfileScrean()];
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavCubit, BottomNavState>(
      builder: (context, state) {
        /// اربط الكنترولر بالكيوبت
        controller.index = state.index;

        return PersistentTabView(
          animationSettings: NavBarAnimationSettings(
            screenTransitionAnimation: ScreenTransitionAnimationSettings(
              animateTabTransition: true,
              curve: Curves.easeInOut,
              duration: Duration(microseconds: 1500),
            ),
          ),
          context,
          controller: controller,
          screens: _screens(),
          items: [
            PersistentBottomNavBarItem(
              icon: SvgPicture.asset(
                AppIcons.homeIcon,
                width: 24.w,
                height: 24.h,
                color: state.index == 0
                    ? AppColors.backgroundColor
                    : const Color(0xFFB8B8B8),
              ),
              title: "home".tr(),
              activeColorPrimary: AppColors.primaryColor,
              inactiveColorPrimary: Colors.grey,
              activeColorSecondary: AppColors.backgroundColor,
            ),
            PersistentBottomNavBarItem(
              icon: SvgPicture.asset(
                AppIcons.searchIcon,
                width: 24.w,
                height: 24.h,
                color: state.index == 1
                    ? AppColors.backgroundColor
                    : const Color(0xFFB8B8B8),
              ),
              title: "search".tr(),
              activeColorPrimary: AppColors.primaryColor,
              inactiveColorPrimary: Colors.grey,
              activeColorSecondary: AppColors.backgroundColor,
            ),
            PersistentBottomNavBarItem(
              icon: SvgPicture.asset(
                AppIcons.addIcon,
                width: 24.w,
                height: 24.h,
                color: state.index == 2
                    ? AppColors.backgroundColor
                    : const Color(0xFFB8B8B8),
              ),
              title: "add".tr(),
              activeColorPrimary: AppColors.primaryColor,
              inactiveColorPrimary: Colors.grey,
              activeColorSecondary: AppColors.backgroundColor,
            ),
            PersistentBottomNavBarItem(
              icon: SvgPicture.asset(
                AppIcons.profileIcon,
                width: 24.w,
                height: 24.h,
                color: state.index == 3
                    ? AppColors.backgroundColor
                    : const Color(0xFFB8B8B8),
              ),
              title: "profile".tr(),
              activeColorPrimary: AppColors.primaryColor,
              inactiveColorPrimary: Colors.grey,
              activeColorSecondary: AppColors.backgroundColor,
            ),
          ],
          backgroundColor: AppColors.backgroundColor,
          handleAndroidBackButtonPress: true,
          resizeToAvoidBottomInset: true,
          stateManagement: true,
          hideNavigationBarWhenKeyboardAppears: true,
          popBehaviorOnSelectedNavBarItemPress: PopBehavior.all,
          confineToSafeArea: true,
          navBarStyle: NavBarStyle.style7,
          onItemSelected: (index) {
            context.read<BottomNavCubit>().changeIndex(index);
          },
        );
      },
    );
  }
}
