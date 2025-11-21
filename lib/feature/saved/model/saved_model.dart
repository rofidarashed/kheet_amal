// saved_report_model.dart
import 'package:cloud_firestore/cloud_firestore.dart';

class SavedReportModel {
  final String id;
  final String reportId;
  final String title;
  final String description;
  final String category;
  final String severity;
  final String location;
  final String imageUrl;
  final DateTime createdAt;
  final DateTime savedAt;

  SavedReportModel({
    required this.id,
    required this.reportId,
    required this.title,
    required this.description,
    required this.category,
    required this.severity,
    required this.location,
    required this.imageUrl,
    required this.createdAt,
    required this.savedAt,
  });

  factory SavedReportModel.fromFirestore(QueryDocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    
    return SavedReportModel(
      id: doc.id,
      reportId: data['id'] ?? doc.id,
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      category: data['category'] ?? '',
      severity: data['severity'] ?? 'medium',
      location: data['location'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
      createdAt: data['createdAt'] != null 
          ? (data['createdAt'] as Timestamp).toDate() 
          : DateTime.now(),
      savedAt: data['savedAt'] != null 
          ? (data['savedAt'] as Timestamp).toDate() 
          : DateTime.now(),
    );
  }
}