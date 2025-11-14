import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kheet_amal/core/utils/app_colors.dart';
import 'package:kheet_amal/feature/profile/widgets/menu_item.dart';

class ChangeLang extends StatelessWidget {
  const ChangeLang({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        final currentLocale = context.locale;

        showModalBottomSheet<void>(
          context: context,
          builder: (BuildContext context) {
            final isArabic = context.locale.languageCode == 'ar';

            return Container(
              color: AppColors.backgroundColor,
              height: 130,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  // Arabic option
                  ListTile(
                    leading: isArabic
                        ? const Icon(Icons.check, color: Colors.green)
                        : const SizedBox(
                            width: 24,
                          ), // Empty space when not selected
                    trailing:  Text(
                      'arabic'.tr(),
                      style: TextStyle(color: AppColors.black, fontSize: 15),
                    ),
                    onTap: () {
                      context.setLocale(const Locale('ar'));
                      Navigator.pop(context);
                    },
                  ),
                  const Divider(thickness: 2),
                  ListTile(
                    trailing:  Text(
                      'english'.tr(),
                      style: TextStyle(color: AppColors.black, fontSize: 15),
                    ),
                    leading: !isArabic
                        ? const Icon(Icons.check, color: Colors.green)
                        : const SizedBox(width: 24),
                    onTap: () {
                      context.setLocale(const Locale('en'));
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            );
          },
        );
      },
      child: MenuItem(title: 'language'.tr(), icon: Icons.language),
    );
  }
}
