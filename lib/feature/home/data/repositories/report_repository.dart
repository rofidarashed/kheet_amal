import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kheet_amal/feature/add_report/data/backblaze_service.dart';
import '../models/report_model.dart';

class ReportRepository {
  final _firestore = FirebaseFirestore.instance;

  Stream<List<ReportModel>> getReportsStream() {
    return _firestore
        .collection('reports')
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
   
Future<void> likeReport({
  required String postId,
  required String userId,
}) async {
  final ref = FirebaseFirestore.instance.collection('reports').doc(postId);

  await ref.update({
    'likes': FieldValue.increment(1),
    'likedBy': FieldValue.arrayUnion([userId]),
  });
}

Future<void> unlikeReport({
  required String postId,
  required String userId,
}) async {
  final ref = FirebaseFirestore.instance.collection('reports').doc(postId);

  await ref.update({
    'likes': FieldValue.increment(-1),
    'likedBy': FieldValue.arrayRemove([userId]),
  });
}

}
