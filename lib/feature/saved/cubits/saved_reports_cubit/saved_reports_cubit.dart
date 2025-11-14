import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kheet_amal/feature/saved/cubits/saved_reports_cubit/saved_reports_state.dart';

class SavedReportsCubit extends Cubit<SavedReportsState> {
  SavedReportsCubit() : super(SavedReportsInitial());

  Future<void> saveReport(String reportId) async {
    try {
      final reportDoc = await FirebaseFirestore.instance
          .collection('reports')
          .doc(reportId)
          .get();
      if (reportDoc.exists) {
        final reportData = reportDoc.data();

        await FirebaseFirestore.instance
            .collection('saved_reports')
            .doc(reportId)
            .set(reportData!);

        emit(SavedReportsToggled(reportId: reportId, isSaved: true));
      } else {
        emit(SavedReportsFailed(message: 'Report not found'));
      }
    } catch (e) {
      emit(SavedReportsFailed(message: e.toString()));
    }
  }

  Future<void> removeReport(String reportId) async {
    try {
      final docRef = FirebaseFirestore.instance
          .collection('saved_reports')
          .doc(reportId);
      final doc = await docRef.get();
      if (doc.exists) {
        await docRef.delete();
      }
      emit(SavedReportsToggled(reportId: reportId, isSaved: false));
    } catch (e) {
      emit(SavedReportsFailed(message: e.toString()));
    }
  }

  Future<void> toggleSaveReport(String reportId) async {
    try {
      final docRef = FirebaseFirestore.instance
          .collection('saved_reports')
          .doc(reportId);
      final snapshot = await docRef.get();
      if (snapshot.exists) {
        await removeReport(reportId);
      } else {
        await saveReport(reportId);
      }
    } catch (e) {
      emit(SavedReportsFailed(message: e.toString()));
    }
  }

  Future<void> checkIfSaved(String reportId) async {
    try {
      final doc = await FirebaseFirestore.instance
          .collection('saved_reports')
          .doc(reportId)
          .get();
      emit(SavedReportsToggled(reportId: reportId, isSaved: doc.exists));
    } catch (e) {
      emit(SavedReportsFailed(message: e.toString()));
    }
  }
}
