import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class NotificationService {
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  Future<void> init() async {
    // 1. Request Permission
    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      debugPrint('User granted permission');
      
      // 2. Get Token (Send this to your backend if you have one)
      String? token = await _messaging.getToken();
      debugPrint("FCM Token: $token");
      
      // 3. Handle Foreground Messages
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        debugPrint('Got a message whilst in the foreground!');
        debugPrint('Message data: ${message.data}');

        if (message.notification != null) {
          debugPrint('Message also contained a notification: ${message.notification}');
          // You can show a local snackbar or dialog here if you want
        }
        
        // NOTE: We don't need to manually save to Firestore here if the 
        // backend sending the notification also writes to Firestore.
        // If there is NO backend, you would need code here to write to Firestore.
      });
    } else {
      debugPrint('User declined or has not accepted permission');
    }
  }
}