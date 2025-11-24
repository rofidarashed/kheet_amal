import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kheet_amal/feature/add_report/data/backblaze_service.dart';
import 'package:kheet_amal/feature/home/data/models/report_model.dart';

class MyReportsRepository {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  Stream<List<ReportModel>> getMyReportsStream() {
    final user = _auth.currentUser;
    if (user == null) {
      return Stream.value([]);
    }

    return _firestore
        .collection('reports')
        .where('userId', isEqualTo: user.uid)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .asyncMap((snapshot) async {
          final reports = <ReportModel>[];

          for (final doc in snapshot.docs) {
            final data = doc.data();

            String imageUrl = data['imageUrl'] ?? '';
            if (imageUrl.contains('reports/')) {
              final fileName = imageUrl.split('reports/').last;
              final secureUrl = await BackblazeService.getTemporaryImageUrl(
                'reports/$fileName',
              );
              if (secureUrl != null) imageUrl = secureUrl;
            }

            reports.add(
              ReportModel.fromMap(doc.id, {...data, 'imageUrl': imageUrl}),
            );
          }

          return reports;
        });
  }

  Future<bool> deleteReportWithImage(String reportId) async {
    try {
      final user = _auth.currentUser;
      if (user == null) {
        throw Exception('User not authenticated');
      }

      // Get report data first to find the image path
      final reportDoc = await _firestore
          .collection('reports')
          .doc(reportId)
          .get();

      if (!reportDoc.exists) {
        throw Exception('Report not found');
      }

      final reportData = reportDoc.data();
      if (reportData?['userId'] != user.uid) {
        throw Exception('You can only delete your own reports');
      }

      // Delete image from Backblaze B2 if it exists
      final imageUrl = reportData?['imageUrl'] ?? '';
      if (imageUrl.isNotEmpty && imageUrl.contains('reports/')) {
        await BackblazeService.deleteImageFromStorage(imageUrl);
      }

      // Delete the report document
      await _firestore.collection('reports').doc(reportId).delete();

      print('OOO Report and image deleted successfully: $reportId');
      return true;
    } catch (e) {
      print('OOO Error deleting report with image: $e');
      throw e;
    }
  }


 

  /// Get a single report by ID (useful for confirmation dialogs)
  Future<ReportModel?> getReportById(String reportId) async {
    try {
      final doc = await _firestore.collection('reports').doc(reportId).get();

      if (!doc.exists) {
        return null;
      }

      final data = doc.data()!;

      // Process image URL
      String imageUrl = data['imageUrl'] ?? '';
      if (imageUrl.contains('reports/')) {
        final fileName = imageUrl.split('reports/').last;
        final secureUrl = await BackblazeService.getTemporaryImageUrl('reports/$fileName');
        if (secureUrl != null) imageUrl = secureUrl;
      }

      return ReportModel.fromMap(doc.id, {...data, 'imageUrl': imageUrl});
    } catch (e) {
      print('OOO Error getting report by ID: $e');
      return null;
    }
  }
}
