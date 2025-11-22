import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NotificationSender {
  static Future<void> sendNotification({
    required String targetUserId,
    required String title,
    required String message,
    required String type,
    required String relatedReportId,
  }) async {
    final currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser != null && currentUser.uid == targetUserId) return;

    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(targetUserId)
          .collection('notifications')
          .add({
        'title': title,
        'body': message,
        'type': type,
        'relatedReportId': relatedReportId,
        'isRead': false,
        'senderId': currentUser?.uid,
        'createdAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}