import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kheet_amal/feature/add_report/data/backblaze_service.dart';
import 'package:kheet_amal/feature/home/data/models/report_model.dart';

class SavedReportsRepository {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  static int savedReportsCount = 0;

  Future<List<ReportModel>> fetchSavedReports() async {
    try {
      final user = _auth.currentUser;
      if (user == null) {
        print('OOO User not logged in');
        return [];
      }

      final snapshot = await _firestore
          .collection('users')
          .doc(user.uid)
          .collection('saved_reports')
          .orderBy('savedAt', descending: true)
          .get();

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

      print('OOO Fetched ${reports.length} saved reports');
      savedReportsCount = reports.length;
      return reports;
    } catch (e) {
      print('OOO Fetch saved reports error: $e');
      return [];
    }
  }

  // Stream for real-time updates
  Stream<List<ReportModel>> getSavedReportsStream() {
    final user = _auth.currentUser;
    if (user == null) {
      return Stream.value([]);
    }

    return _firestore
        .collection('users')
        .doc(user.uid)
        .collection('saved_reports')
        .orderBy('savedAt', descending: true)
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
}
