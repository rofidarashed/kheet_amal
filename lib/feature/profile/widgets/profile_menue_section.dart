import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:kheet_amal/core/utils/app_icons.dart';
import 'package:kheet_amal/core/widgets/custom_confirm_dialog.dart';
import 'package:kheet_amal/feature/auth/cubit/auth_cubit.dart';
import 'package:kheet_amal/feature/profile/my_reports_screen.dart';
import 'package:kheet_amal/feature/profile/widgets/change_lang.dart';
import 'package:kheet_amal/feature/saved/saved_screen.dart';
import 'package:kheet_amal/feature/settings/settings_home.dart';
import 'menu_item.dart';

class ProfileMenuSection extends StatelessWidget {
  final AuthCubit authCubit;

  const ProfileMenuSection({super.key, required this.authCubit});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MenuItem(
          title: 'saved'.tr(),
          icon: Icons.bookmark_border,
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SavedScreen()),
          ),
        ),
        MenuItem(
          title: 'reports'.tr(),
          icon: Icons.edit_outlined,
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MyReports()),
          ),
        ),
        const ChangeLang(),
        MenuItem(
          title: 'settings'.tr(),
          icon: Icons.settings,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SettingsHome()),
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
  }
}
