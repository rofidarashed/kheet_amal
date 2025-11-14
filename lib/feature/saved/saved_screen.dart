import 'package:easy_localization/easy_localization.dart';
import 'package:kheet_amal/core/utils/app_colors.dart';
import 'package:kheet_amal/feature/saved/widgets/saved_is_empty.dart';
import 'package:kheet_amal/feature/saved/widgets/saved_is_full.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SavedScreen extends StatelessWidget {
  SavedScreen({super.key});

  static const String routeName = "saved";

  List<String> savedList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: Text("saved".tr()),
        backgroundColor: AppColors.backgroundColor,
      ),
      body: savedList.isEmpty ? Emptysaved() : Fullsaved(),
    );
  }
}
