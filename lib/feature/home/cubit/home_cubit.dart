import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kheet_amal/feature/home/cubit/home_state.dart';
import 'package:kheet_amal/feature/home/data/models/report_model.dart';
import 'package:kheet_amal/feature/notification/service/notification_service_v1.dart';
import '../data/repositories/report_repository.dart';

class HomeCubit extends Cubit<HomeState> {
  final ReportRepository _repository;
  StreamSubscription? _reportsSubscription;

  HomeCubit(this._repository) : super(HomeState.initial());
  final user = FirebaseAuth.instance.currentUser!;

  void loadReports() {
    emit(state.copyWith(isLoading: true));

    _reportsSubscription?.cancel();

    _reportsSubscription = _repository.getReportsStream().listen(
      (reports) {
        emit(state.copyWith(isLoading: false, reports: reports));
      },
      onError: (error) {
        print("Stream Error: $error");
        emit(state.copyWith(isLoading: false));
      },
    );
  }

  @override
  Future<void> close() {
    _reportsSubscription?.cancel();
    return super.close();
  }

  Future<void> toggleLike(String reportId) async {
    final uid = user.uid;
    final reports = List<ReportModel>.from(state.reports);

    final index = reports.indexWhere((r) => r.id == reportId);
    if (index == -1) return;

    final report = reports[index];
    final wasLiked = report.isLiked;

    try {
      if (wasLiked) {
        report.isLiked = false;
        report.likes--;
        report.likedBy.remove(uid);
        emit(state.copyWith(reports: reports));
        await _repository.unlikeReport(postId: reportId, userId: uid);
      } else {
        report.isLiked = true;
        report.likes++;
        if (!report.likedBy.contains(uid)) {
          report.likedBy.add(uid);
        }

        if (report.userId != uid) {
          String senderName = user.displayName ?? 'فاعل خير';
          try {
            final senderDoc = await FirebaseFirestore.instance
                .collection('users')
                .doc(uid)
                .get();

            if (senderDoc.exists && senderDoc.data() != null) {
              senderName = senderDoc.data()!['name'] ?? senderName;
            }
          } catch (e) {
            debugPrint("Error fetching sender name: $e");
          }

          await FirebaseFirestore.instance
              .collection('users')
              .doc(report.userId)
              .collection('notifications')
              .add({
                'title': "دعم جديد",
                // 'body': "قام $senderName بدعم بلاغك عن ${report.childName}",
                'body':
                    "بلاغلك عن ${report.childName} تلقى دعمًا من أحد المستخدمين .",
                'type': "support",
                'relatedReportId': reportId,
                'isRead': false,
                'senderId': uid,
                'createdAt': FieldValue.serverTimestamp(),
              });
          final ownerDoc = await FirebaseFirestore.instance
              .collection('users')
              .doc(report.userId)
              .get();

          if (ownerDoc.exists && ownerDoc.data()!.containsKey('fcmToken')) {
            String ownerToken = ownerDoc.data()!['fcmToken'];

            await NotificationServiceV1.sendPushNotification(
              fcmToken: ownerToken,
              title: "دعم جديد ❤️",
              body: "قام شخص ما بدعم بلاغك عن ${report.childName}",
              data: {"reportId": reportId, "type": "support"},
            );
          }
        }

        emit(state.copyWith(reports: reports));
        await _repository.likeReport(postId: reportId, userId: uid);
      }
    } catch (e) {
      report.isLiked = wasLiked;
      emit(state.copyWith(reports: reports));
    }
  }
}
