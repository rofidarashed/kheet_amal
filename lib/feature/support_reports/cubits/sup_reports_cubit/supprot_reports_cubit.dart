import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kheet_amal/feature/support_reports/cubits/sup_reports_cubit/supprot_reports_state.dart';

class SupportReportsCubit extends Cubit<SupportReportsState> {
  SupportReportsCubit() : super(SupportReportsInitial());

  
  CollectionReference<Map<String, dynamic>> _userSupportReports(String userId) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('support_reports');
  }

  Future<void> supportReport(String reportId) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        emit(SupportReportsFailed(message: 'User not logged in'));
        return;
      }

      final reportDoc = await FirebaseFirestore.instance
          .collection('reports')
          .doc(reportId)
          .get();

      if (!reportDoc.exists) {
        emit(SupportReportsFailed(message: 'Report not found'));
        return;
      }

      final reportData = reportDoc.data();
      debugPrint('Supporting report: $reportId for user: ${user.uid}');
      
      await _userSupportReports(user.uid).doc(reportId).set({
        ...reportData!,
        'supportedAt': FieldValue.serverTimestamp(),
      });

      debugPrint('✅ Report supported successfully');
      emit(SupportReportsToggled(reportId: reportId, isSupported: true));
    } catch (e) {
      debugPrint('🔥 Error supporting report: $e');
      emit(SupportReportsFailed(message: e.toString()));
    }
  }

  Future<void> unsupportReport(String reportId) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        emit(SupportReportsFailed(message: 'User not logged in'));
        return;
      }

      final docRef = _userSupportReports(user.uid).doc(reportId);
      final doc = await docRef.get();

      if (doc.exists) {
        await docRef.delete();
        debugPrint('✅ Report unsupported successfully');
      }

      emit(SupportReportsToggled(reportId: reportId, isSupported: false));
    } catch (e) {
      debugPrint('🔥 Error unsupporting report: $e');
      emit(SupportReportsFailed(message: e.toString()));
    }
  }

  Future<void> toggleSupport(String reportId) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        emit(SupportReportsFailed(message: 'User not logged in'));
        return;
      }

      final docRef = _userSupportReports(user.uid).doc(reportId);
      final snapshot = await docRef.get();

      if (snapshot.exists) {
        await unsupportReport(reportId);
      } else {
        await supportReport(reportId);
      }
    } catch (e) {
      debugPrint('🔥 Error toggling support: $e');
      emit(SupportReportsFailed(message: e.toString()));
    }
  }

  Future<void> checkIfSupported(String reportId) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        emit(SupportReportsToggled(reportId: reportId, isSupported: false));
        return;
      }

      final doc = await _userSupportReports(user.uid).doc(reportId).get();
      emit(SupportReportsToggled(reportId: reportId, isSupported: doc.exists));
    } catch (e) {
      debugPrint('🔥 Error checking support: $e');
      emit(SupportReportsFailed(message: e.toString()));
    }
  }
}
