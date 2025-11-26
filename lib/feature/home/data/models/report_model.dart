import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
  final String? userId;
  final String userName;
  final DateTime createdAt;
   int likes;
  bool isLiked;
  List<String> likedBy;


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
    required this.userId,
    required this.userName,
    required this.createdAt,
    this.likes = 0,
    this.isLiked = false,
    this.likedBy = const [],
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
      userId: data['userId'] ?? '',
      userName: data['userName'] ?? '',
      createdAt: _parseDateTime(data['createdAt']),
      likes: (data['likes'] ?? 0),
    likedBy: List<String>.from(data['likedBy'] ?? []),

    isLiked: (data['likedBy'] ?? []).contains(
      FirebaseAuth.instance.currentUser!.uid,
    ),
    );
  }

  static DateTime _parseDateTime(dynamic dateData) {
    if (dateData == null) return DateTime.now();
    
    try {
      if (dateData is Timestamp) {
        return dateData.toDate();
      } else if (dateData is String) {
        return DateTime.parse(dateData);
      } else if (dateData is int) {
        return DateTime.fromMillisecondsSinceEpoch(dateData);
      } else {
        return DateTime.now();
      }
    } catch (e) {
      print('Error parsing date: $e');
      return DateTime.now();
    }
  }

  factory ReportModel.empty() {
    return ReportModel(
      reportType: '',
      gender: '',
      skinColor: '',
      eyeColor: '',
      hairColor: '',
      distinctiveMarks: '',
      description: '',
      clothes: '',
      phone2: '',
      date: null,
      id: '',
      startAge: 0,
      endAge: 0,
      childName: '',
      place: '',
      imageUrl: '',
      phone1: '',
      userId: '',
      userName: '',
      createdAt: DateTime.now(),
    );
  }
}