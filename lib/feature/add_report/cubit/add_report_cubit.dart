import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kheet_amal/feature/add_report/cubit/add_report_state.dart';
import 'package:kheet_amal/feature/add_report/enums/enums.dart';

class AddReportCubit extends Cubit<AddReportState> {
  AddReportCubit() : super(AddReportState.initial());

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

  final ImagePicker _picker = ImagePicker();
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
}
