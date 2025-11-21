import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kheet_amal/feature/support_reports/cubits/sup_reports_cubit/supprot_reports_state.dart';
import 'package:kheet_amal/feature/notification/data/notification_sender.dart';

class SupportReportsCubit extends Cubit<SupportReportsState> {
  SupportReportsCubit() : super(SupportReportsInitial());

  Future<void> supportReport(String reportId) async {
    try {
      final reportDoc = await FirebaseFirestore.instance
          .collection('reports')
          .doc(reportId)
          .get();

      if (reportDoc.exists) {
        final reportData = reportDoc.data();

        await FirebaseFirestore.instance
            .collection('support_reports')
            .doc(reportId)
            .set(reportData!);

        final ownerId = reportData['userId'];
        
        if (ownerId != null) {
          await NotificationSender.sendNotification(
            targetUserId: ownerId,
            title: "دعم جديد",
            message: "حصل بلاغك على دعم جديد من أحد المستخدمين", 
            type: "support",
            relatedReportId: reportId,
          );
        }

        emit(SupportReportsToggled(reportId: reportId, isSupported: true));
      } else {
        emit(SupportReportsFailed(message: 'Report not found'));
      }
    } catch (e) {
      emit(SupportReportsFailed(message: e.toString()));
    }
  }

  Future<void> unsupportReport(String reportId) async {
    try {
      final docRef = FirebaseFirestore.instance.collection('support_reports').doc(reportId);
      final doc = await docRef.get();
      if (doc.exists) await docRef.delete();
      
      emit(SupportReportsToggled(reportId: reportId, isSupported: false));
    } catch (e) {
      emit(SupportReportsFailed(message: e.toString()));
    }
  }

  Future<void> toggleSupport(String reportId) async {
    try {
      final docRef = FirebaseFirestore.instance.collection('support_reports').doc(reportId);
      final snapshot = await docRef.get();
      if (snapshot.exists) {
        await unsupportReport(reportId);
      } else {
        await supportReport(reportId);
      }
    } catch (e) {
      emit(SupportReportsFailed(message: e.toString()));
    }
  }

  Future<void> checkIfSupported(String reportId) async {
    try {
      final doc = await FirebaseFirestore.instance.collection('support_reports').doc(reportId).get();
      emit(SupportReportsToggled(reportId: reportId, isSupported: doc.exists));
    } catch (e) {
      emit(SupportReportsFailed(message: e.toString()));
    }
  }
}