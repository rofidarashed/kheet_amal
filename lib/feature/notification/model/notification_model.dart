import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationModel {
  final String id;
  final String title;
  final String message;
  final DateTime time;
  final String type;
  final bool isRead;

  NotificationModel({
    required this.id,
    required this.title,
    required this.message,
    required this.time,
    required this.type,
    required this.isRead,
  });

  factory NotificationModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return NotificationModel(
      id: doc.id,
      title: data['title'] ?? '',
      message: data['body'] ?? '',
      time: (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      type: data['type'] ?? 'update',
      isRead: data['isRead'] ?? false,
    );
  }

  IconData get icon {
    switch (type) {
      case 'update':
        return Icons.check_circle_outline;
      case 'comment':
        return Icons.chat_bubble_outline;
      case 'support':
        return Icons.favorite_border;
      default:
        return Icons.notifications_none;
    }
  }

  Color get color {
    switch (type) {
      case 'update':
        return Colors.green;
      case 'comment':
        return Colors.indigo;
      case 'support':
        return Colors.purple;
      default:
        return Colors.orange;
    }
  }
}