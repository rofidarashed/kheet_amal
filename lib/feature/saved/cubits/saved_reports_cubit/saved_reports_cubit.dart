import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kheet_amal/feature/saved/cubits/saved_reports_cubit/saved_reports_state.dart';

class SavedReportsCubit extends Cubit<SavedReportsState> {
  SavedReportsCubit() : super(SavedReportsInitial());

  CollectionReference<Map<String, dynamic>> _userSavedReports(String userId) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('saved_reports');
  }

  Future<void> saveReport(String reportId) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        emit(SavedReportsFailed(message: 'User not logged in'));
        return;
      }

      final reportDoc = await FirebaseFirestore.instance
          .collection('reports')
          .doc(reportId)
          .get();

      if (!reportDoc.exists) {
        emit(SavedReportsFailed(message: 'Report not found'));
        return;
      }

      final reportData = reportDoc.data();
      await _userSavedReports(user.uid)
          .doc(reportId)
          .set({
            'id': reportDoc.id,
            ...?reportData,
            'savedAt': FieldValue.serverTimestamp()
          });

      emit(SavedReportsToggled(reportId: reportId, isSaved: true));
    } catch (e) {
      emit(SavedReportsFailed(message: e.toString()));
    }
  }

  Future<void> removeReport(String reportId) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        emit(SavedReportsFailed(message: 'User not logged in'));
        return;
      }

      final docRef = _userSavedReports(user.uid).doc(reportId);
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
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        emit(SavedReportsFailed(message: 'User not logged in'));
        return;
      }

      final docRef = _userSavedReports(user.uid).doc(reportId);
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
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        emit(SavedReportsToggled(reportId: reportId, isSaved: false));
        return;
      }

      final doc = await _userSavedReports(user.uid).doc(reportId).get();
      emit(SavedReportsToggled(reportId: reportId, isSaved: doc.exists));
    } catch (e) {
      emit(SavedReportsFailed(message: e.toString()));
    }
  }
}
