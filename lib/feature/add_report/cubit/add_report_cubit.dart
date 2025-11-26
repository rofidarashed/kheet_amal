// ignore_for_file: unnecessary_null_comparison

import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kheet_amal/feature/add_report/cubit/add_report_state.dart';
import 'package:kheet_amal/feature/add_report/enums/enums.dart';

import '../data/backblaze_service.dart';

class AddReportCubit extends Cubit<AddReportState> {
  AddReportCubit() : super(AddReportState.initial());
  final TextEditingController nameController = TextEditingController();
  final TextEditingController marksController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  final BackblazeService _backblazeService = BackblazeService();
  final user = FirebaseAuth.instance.currentUser;
  @override
  Future<void> close() {
    nameController.dispose();
    marksController.dispose();
    descriptionController.dispose();
    return super.close();
  }

  void selectReportType(ReportType reportType) {
    emit(state.copyWith(reportType: reportType));
  }

  void selectGender(GenderType gender) {
    emit(state.copyWith(gender: gender));
  }

  void selectSkinColor(SkinColor skinColor) {
    emit(state.copyWith(skinColor: skinColor));
  }

  void selectEyeColor(EyeColor eyeColor) {
    emit(state.copyWith(eyeColor: eyeColor));
  }

  void selectHairColor(HairColor hairColor) {
    emit(state.copyWith(hairColor: hairColor));
  }

  void selectAge(int startAge, int endAge) {
    emit(state.copyWith(startAge: startAge, endAge: endAge));
  }

  void selectContactCode(String contactCode) {
    emit(state.copyWith(contactCode: contactCode));
  }

  void selectImage() async {
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 85,
    );

    if (pickedFile != null) {
      File file = File(pickedFile.path);
      emit(state.copyWith(image: File(pickedFile.path)));
      int sizeInBytes = await file.length();
      double sizeInMb = sizeInBytes / (1024 * 1024);
      debugPrint('File size: ${sizeInMb.toStringAsFixed(2)} MB');
    }
  }

  Future<void> pickDate({
    required BuildContext context,
    required TextEditingController dateController,
  }) async {
    final results = await showCalendarDatePicker2Dialog(
      context: context,
      config: CalendarDatePicker2WithActionButtonsConfig(
        calendarType: CalendarDatePicker2Type.single,
      ),
      dialogSize: const Size(325, 400),
      borderRadius: BorderRadius.circular(15),
      value: state.lastSeenDate != null ? [state.lastSeenDate!] : [],
    );

    if (results != null && results.isNotEmpty) {
      emit(state.copyWith(lastSeenDate: results[0]));
      dateController.text =
          '${state.lastSeenDate!.day}/${state.lastSeenDate!.month}/${state.lastSeenDate!.year}';
    }
  }

  Future<void> submitReport({
    required String place,
    required String clothes,
    required String phone1,
    required String phone2,
    String? description,
  }) async {
    try {
      String imageUrl = 'static/images/default_image.png';
      if (state.image != null) {
        final uploadedUrl = await _backblazeService.uploadImage(state.image!);
        if (uploadedUrl != null) {
          imageUrl = uploadedUrl;
        }
      }
      DocumentReference docRef = await FirebaseFirestore.instance
          .collection('reports')
          .add({
            'userId': user!.uid,
            'userEmail': user!.email,
            'userPhone': user!.phoneNumber,
            'userName': user!.displayName,
            'reportType': state.reportType.name,
            'gender': state.gender.name,
            'skinColor': state.skinColor.name,
            'eyeColor': state.eyeColor.name,
            'hairColor': state.hairColor.name,
            'startAge': state.startAge,
            'endAge': state.endAge,
            'childName': nameController.text.trim(),
            'distinctiveMarks': marksController.text.trim(),
            'description': descriptionController.text.trim(),
            'place': place,
            'clothes': clothes,
            'date': state.lastSeenDate?.toIso8601String(),
            'contactCode': state.contactCode,
            'phone1': phone1,
            'phone2': phone2,
            'imageUrl': imageUrl,
            'createdAt': FieldValue.serverTimestamp(),
                 'likes': 0,
      'likedBy': [],
          });
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user!.uid)
          .collection('notifications')
          .add({
            'title': "تحديث", 
            'body':
                "تم إضافة بلاغك بنجاح، سيتم مراجعته وإبلاغك بأي تحديثات.", 
            'type': "update", 
            'relatedReportId': docRef.id, 
            'isRead': false,
            'senderId': "SYSTEM", 
            'createdAt': FieldValue.serverTimestamp(),
          });
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
