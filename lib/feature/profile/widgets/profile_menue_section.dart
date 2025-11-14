import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:kheet_amal/core/utils/app_colors.dart';
import 'package:kheet_amal/feature/auth/cubit/auth_cubit.dart';
import 'package:kheet_amal/feature/profile/widgets/change_lang.dart';
import 'menu_item.dart';

class ProfileMenuSection extends StatelessWidget {
  final AuthCubit authCubit;

  const ProfileMenuSection({super.key, required this.authCubit});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MenuItem(title: 'saved'.tr(), icon: Icons.bookmark_border),
        MenuItem(title: 'reports'.tr(), icon: Icons.edit_outlined),
        const ChangeLang(),
        MenuItem(title: 'settings'.tr(), icon: Icons.settings),
        InkWell(
          onTap: () {
            AwesomeDialog(
              btnOkColor: AppColors.red,
              btnCancelColor: AppColors.inactiveTrackbarColor,
              context: context,
              animType: AnimType.bottomSlide,
              dialogType: DialogType.error,
              body: Center(
                child: Text(
                  'هل انت متأكد من\nتسجيل الخروج؟',
                  style: TextStyle(fontSize: 22.sp),
                  textAlign: TextAlign.center,
                ),
              ),
              btnCancelOnPress: () {},
              btnOkOnPress: () {
                authCubit.logout();
              },
            ).show();
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
