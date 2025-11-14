class ReportModel {
  final String id;
  final String reportType;
  final String gender;
  final String skinColor;
  final String eyeColor;
  final String hairColor;
  final int startAge;
  final int endAge;
  final String childName;
  final String distinctiveMarks;
  final String description;
  final String place;
  final String clothes;
  final String phone1;
  final String phone2;
  final String imageUrl;
  final DateTime? date;

  ReportModel({
    required this.id,
    required this.reportType,
    required this.gender,
    required this.skinColor,
    required this.eyeColor,
    required this.hairColor,
    required this.startAge,
    required this.endAge,
    required this.childName,
    required this.distinctiveMarks,
    required this.description,
    required this.place,
    required this.clothes,
    required this.phone1,
    required this.phone2,
    required this.imageUrl,
    required this.date,
  });

  factory ReportModel.fromMap(String id, Map<String, dynamic> data) {
    return ReportModel(
      id: id,
      reportType: data['reportType'] ?? '',
      gender: data['gender'] ?? '',
      skinColor: data['skinColor'] ?? '',
      eyeColor: data['eyeColor'] ?? '',
      hairColor: data['hairColor'] ?? '',
      startAge: data['startAge'] ?? 0,
      endAge: data['endAge'] ?? 0,
      childName: data['childName'] ?? '',
      distinctiveMarks: data['distinctiveMarks'] ?? '',
      description: data['description'] ?? '',
      place: data['place'] ?? '',
      clothes: data['clothes'] ?? '',
      phone1: data['phone1'] ?? '',
      phone2: data['phone2'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
      date: data['date'] != null ? DateTime.tryParse(data['date']) : null,
    );
  }
}
