import 'package:easy_localization/easy_localization.dart';
import 'package:kheet_amal/core/utils/app_colors.dart';
import 'package:kheet_amal/feature/archives_screen/widgets/archives_is_empty.dart';
import 'package:kheet_amal/feature/archives_screen/widgets/archives_is_full.dart';
import 'package:flutter/material.dart';

class Archives extends StatelessWidget {
  Archives({super.key});

  static const String routeName = "Archives";

  List<String> ArchivesList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(title: Text("Archives".tr()),backgroundColor: AppColors.backgroundColor,),
      body: ArchivesList.isEmpty ? EmptyArchives() : FullArchives(),
    );
  }
}