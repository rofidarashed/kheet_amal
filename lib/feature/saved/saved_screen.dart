import 'dart:developer';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kheet_amal/core/utils/app_colors.dart';
import 'package:kheet_amal/feature/home/data/models/report_model.dart';
import 'package:kheet_amal/feature/saved/saved_repo.dart';
import 'package:kheet_amal/feature/saved/widgets/saved_is_empty.dart';
import 'package:kheet_amal/feature/saved/widgets/saved_is_full.dart';

class SavedScreen extends StatelessWidget {
  const SavedScreen({super.key});

  static const String routeName = "saved";

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final repository = SavedReportsRepository();

    if (user == null) {
      return const Scaffold(
        body: Center(child: Text("Please login to see saved reports")),
      );
    }

    log('SavedScreen: User ID: ${user.uid}');

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: Text("saved".tr()),
        backgroundColor: AppColors.backgroundColor,
      ),
      body: StreamBuilder<List<ReportModel>>(
        stream: repository.getSavedReportsStream(),
        builder: (context, snapshot) {
          print("SavedScreen: Connection state: ${snapshot.connectionState}");
          print("SavedScreen: Has data: ${snapshot.hasData}");
          print("SavedScreen: Has error: ${snapshot.hasError}");

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            print("SavedScreen: Error: ${snapshot.error}");
            return Center(child: Text("Error: ${snapshot.error}"));
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            print("SavedScreen: No saved reports found");
            return Emptysaved();
          }

          final savedReports = snapshot.data!;
          print("SavedScreen: Found ${savedReports.length} saved reports.");

          // Debug: Print first report details
          if (savedReports.isNotEmpty) {
            final firstReport = savedReports.first;
            print("SavedScreen: First report - ID: ${firstReport.id}, Child: ${firstReport.childName}, Image: ${firstReport.imageUrl}");
          }

          return Fullsaved(savedReports: savedReports);
        },
      ),
    );
  }
}