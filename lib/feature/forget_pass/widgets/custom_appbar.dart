import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kheet_amal/core/utils/app_colors.dart';
import 'package:kheet_amal/core/utils/app_images.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final isArabic = Directionality.of(context) == TextDirection.rtl;

    return AppBar(
      backgroundColor: AppColors.backgroundColor,
      elevation: 0,
      leading: !isArabic
          ? IconButton(
        onPressed: () => Navigator.pop(context),
          icon:SvgPicture.asset(AppImages.backIcon),
      )
          :SizedBox.shrink(),
      actions: isArabic
          ? [
        IconButton(
          onPressed: () => Navigator.pop(context),
          icon:SvgPicture.asset(AppImages.backIcon)
          // Icon(Icons.arrow_back_ios, color: Colors.black, size: 20.sp),
        ),
      ]
          : null,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
