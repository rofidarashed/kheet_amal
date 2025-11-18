import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kheet_amal/core/utils/app_colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kheet_amal/feature/saved/widgets/saved_is_empty.dart';
import 'package:kheet_amal/feature/saved/widgets/saved_is_full.dart';

class SavedScreen extends StatelessWidget {
  SavedScreen({super.key});

  static const String routeName = "saved";

  final CollectionReference savedCollection =
      FirebaseFirestore.instance.collection('saved_reports');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: Text("saved".tr()),
        backgroundColor: AppColors.backgroundColor,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: savedCollection.snapshots(),
        builder: (context, snapshot) {
          print("SavedScreen: Connection state: ${snapshot.connectionState}");
          
          if (snapshot.connectionState == ConnectionState.waiting) {
            print("SavedScreen: Waiting for data...");
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            print("SavedScreen: No saved reports found.");
            return Emptysaved();
          }

          var savedDocs = snapshot.data!.docs;
          print("SavedScreen: Found ${savedDocs.length} saved reports.");
          savedDocs.forEach((doc) => print("SavedScreen Doc: ${doc.data()}"));

          return Fullsaved(savedDocs: savedDocs);
        },
      ),
    );
  }
}
