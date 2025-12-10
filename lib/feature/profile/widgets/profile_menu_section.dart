import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kheet_amal/core/utils/app_icons.dart';
import 'package:kheet_amal/core/widgets/custom_confirm_dialog.dart';
import 'package:kheet_amal/feature/auth/cubit/auth_cubit.dart';
import 'package:kheet_amal/feature/profile/cubits/cubit/my_reports_cubit.dart';
import 'package:kheet_amal/feature/profile/data/my_reports_repo.dart';
import 'package:kheet_amal/feature/profile/my_reports_screen.dart';
import 'package:kheet_amal/feature/profile/widgets/change_lang.dart';
import 'package:kheet_amal/feature/saved/cubits/saved_reports_cubit/saved_reports_cubit.dart';
import 'package:kheet_amal/feature/saved/saved_screen.dart';
import 'package:kheet_amal/feature/settings/settings_home.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'menu_item.dart';

class ProfileMenuSection extends StatelessWidget {
  final AuthCubit authCubit;

  const ProfileMenuSection({super.key, required this.authCubit});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MyReportsCubit(MyReportsRepository())..loadReports(),
      child: Builder(
        builder: (context) {
          return Column(
            children: [
              MenuItem(
                title: 'saved'.tr(),
                icon: Icons.bookmark_border,
                count: context.watch<SavedReportsCubit>().savedReportsCount,
                onTap: () => PersistentNavBarNavigator.pushNewScreen(
                  context,
                  screen: SavedScreen(),
                  withNavBar: false,
                ),
              ),
              MenuItem(
                title: 'reports'.tr(),
                icon: Icons.edit_outlined,
                count: context.watch<MyReportsCubit>().reportsCount,
                onTap: () => PersistentNavBarNavigator.pushNewScreen(
                  context,
                  screen: MyReports(),
                  withNavBar: false,
                ),
              ),
              const ChangeLang(),
              MenuItem(
                title: 'settings'.tr(),
                icon: Icons.settings,
                onTap: () {
                  PersistentNavBarNavigator.pushNewScreen(
                    context,
                    screen: const SettingsHome(),
                    withNavBar: false,
                  );
                },
              ),

              InkWell(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return CustomConfirmationDialog(
                        onPressed: () => authCubit.logout(),
                        icon: AppIcons.logoutIcon,
                        title: 'are_you_sure_logout'.tr(),
                        actionText: 'logout'.tr(),
                      );
                    },
                  );
                },
                child: MenuItem(
                  title: 'logout'.tr(),
                  icon: Icons.power_settings_new,
                  iconColor: Colors.red,
                  textColor: Colors.red,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
