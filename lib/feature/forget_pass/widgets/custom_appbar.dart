import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kheet_amal/core/utils/app_colors.dart';
import 'package:kheet_amal/core/utils/app_icons.dart';

class CustomPassAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomPassAppBar({super.key,});

  @override
  Widget build(BuildContext context) {
    final isArabic = Directionality.of(context) == TextDirection.rtl;

    return AppBar(
      backgroundColor: AppColors.backgroundColor,
      elevation: 0,
      leading: !isArabic
          ? IconButton(
              onPressed: () => Navigator.pop(context),
              icon: SvgPicture.asset(AppIcons.backIcon),
            )
          : SizedBox.shrink(),
      actions: isArabic
          ? [
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: SvgPicture.asset(AppIcons.backIcon),
                // Icon(Icons.arrow_back_ios, color: Colors.black, size: 20.sp),
              ),
            ]
          : null,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
