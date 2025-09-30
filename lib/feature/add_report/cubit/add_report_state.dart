import 'dart:io';

import 'package:kheet_amal/feature/add_report/enums/enums.dart';

class AddReportState {
  final ReportType reportType;
  final GenderType gender;
  final SkinColor skinColor;
  final EyeColor eyeColor;
  final HairColor hairColor;
  final int startAge;
  final int endAge;
  final File? image;
  final String contactCode;
  final DateTime? lastSeenDate;

  const AddReportState({
    required this.reportType,
    required this.gender,
    required this.skinColor,
    required this.eyeColor,
    required this.hairColor,
    required this.startAge,
    required this.endAge,
    required this.image,
    required this.contactCode,
    required this.lastSeenDate,
  });

  AddReportState copyWith({
    ReportType? reportType,
    GenderType? gender,
    SkinColor? skinColor,
    EyeColor? eyeColor,
    HairColor? hairColor,
    int? startAge,
    int? endAge,
    File? image,
    String? contactCode,
    DateTime? lastSeenDate,
  }) {
    return AddReportState(
      reportType: reportType ?? this.reportType,
      gender: gender ?? this.gender,
      skinColor: skinColor ?? this.skinColor,
      eyeColor: eyeColor ?? this.eyeColor,
      hairColor: hairColor ?? this.hairColor,
      startAge: startAge ?? this.startAge,
      endAge: endAge ?? this.endAge,
      image: image ?? this.image,
      contactCode: contactCode ?? this.contactCode,
      lastSeenDate: lastSeenDate ?? this.lastSeenDate,
    );
  }

  factory AddReportState.initial() {
    return const AddReportState(
      reportType: ReportType.lostChild,
      gender: GenderType.male,
      skinColor: SkinColor.light,
      eyeColor: EyeColor.blue,
      hairColor: HairColor.brown,
      startAge: 3,
      endAge: 9,
      image: null,
      contactCode: "+20",
      lastSeenDate: null,
    );
  }
}
