import 'package:googleapis_auth/auth_io.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class NotificationServiceV1 {
  static const Map<String, dynamic> _serviceAccountJson = {
    "type": "service_account",
    "project_id": "kheet-amal",
    "private_key_id": "f7b52a698afd90e5586f1207f7c23b9c2630337a",
    "private_key":
        "-----BEGIN PRIVATE KEY-----\nMIIEugIBADANBgkqhkiG9w0BAQEFAASCBKQwggSgAgEAAoIBAQDiO3VJcd4fMk7P\nFFVSb4goLW7epbcSa9w99EVbyObetJScNg9beZi6GTO+NgtLEfi22E4CHmo9KfN3\neu1J/6kI/MELwogBeVrio5CmT/WK2fRAj9LnrgpplYRxDygxRhnbJgxbqUejmQXZ\niAxlyRHe6lsn2Wf//v78iI8bD/OrjwkpY1C3BQqfGkqXMzb4iMKAarvRnJjbDpyX\nG7AkJ1M4SOjr262/xXThlxeGddW4as3ZDvCVHTGYEcvqVwywtHPcbifKuRtGc24R\nXWrq7VM5TqXIptvN0BaA6aRgnNGKKSiM6bjbt6ZmoLzPAYeuOYGf9hd+QroVP2/1\nrB4KSG8ZAgMBAAECgf8Pb3aRJd5oQn3q1kUeJ48AhBkMbTD/ZhhLdyvu9Rt2FnWm\n3YDZZ5Sdpm/hV0YYpe4OAxqCpBkkEzAi9sixVOJVuqTGjwfJmn4QcAduhLDEpl6M\nb4f0RrhvJm8WFHsyFKdqssd6aHi/Fyks4ZLl53zIHzVMLWcNQ4vd81ElmJuyKc04\n0ORnHfCsmibxTnm7t7mHTcYGofJq2hyfxwm2b3QA/zi3O4w/KGR9AOYdz0zGvbd4\n/FsZE4vqbtMyG1HneV5jaYZuthQrzn13WkWyiCDSRP6u5o4CjN+uyjQcj9QgA/f3\nq070hlS1Z3pm5I3FkduShVUy6zfgb8zxmlbuUakCgYEA8bQUaSLzRMele/MckOGn\nNuk7+7TG0tk3RZRrtLePIX4fme+G1FzuPO4TY6IBOUvdfcDYrwG/aF7eH/WDJ/GP\ntY0+wesf7cbpHv1fMZAEWvtINIJa3MWNArb4yj1RkvShiE+hf7DPHQjPdImA+rz7\nmzQJEwbNSUceW2ShZUe11FsCgYEA750cYHafT73roIzBYCG6lqN3g5XnwlfXZoFg\n54nPadLU57ckCg49PSNzR6FltwJsrqw03K8673IsuTdLW8r0xjAynt4WkejK4JNd\n54XX+9xZQhb5XSrgI+o60snodQFXWiNS1h+spjDYUPm28KM3mw5wXJrazqwaFdRp\nQYv5VJsCgYBwCCFBzkJmCggJWNlPylhAWoFEHTnfN3GoHbCCtmZwhs5NArpDKsP+\nl/eCwe/BSAnlJQMKs0uuK/LXa2wckpoi89I3/izxgLZDd/ustG1gYoLIW/eTxzmi\nHX9Z9mweKqfIz+gykJifg5rtEGMpVXlmKgtet1Nl+MH4aL9qe3+rawKBgH2FBOd3\nXG8uYy+AbJBKOu9MhH/22ChTUbAN2FCSPYgG/KbBpmxqFyRe3LXKU3kyGPLLnQl5\n9dqXKdyAncZhJCZp+yqD1rjqhNRt/kQZNhJm1I8tb8WhfzbxLY1cXZxlbnf2hx9K\nCmworDiHB5E5PxjH0I6CRFr9htCmq9i9VYg/AoGAVDM8rOAFZi43qcvr1BXMpfp9\n24VjGwHp1vtJW8YeY79CBgfAsmPKNsfRuzhGpP6mqkcDGCWAYVtVOzLtsLP4nlRJ\nktQKziRZuaLrhcOzz2+UA1IvAqi491WIJpVJJr8KnxuqKybUx9SAeISpdaahIi6o\nmuUyZpQBZ4vqaAUucQA=\n-----END PRIVATE KEY-----\n",
    "client_email":
        "firebase-adminsdk-fbsvc@kheet-amal.iam.gserviceaccount.com",
    "client_id": "115074443290388195509",
    "auth_uri": "https://accounts.google.com/o/oauth2/auth",
    "token_uri": "https://oauth2.googleapis.com/token",
    "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
    "client_x509_cert_url":
        "https://www.googleapis.com/robot/v1/metadata/x509/firebase-adminsdk-fbsvc%40kheet-amal.iam.gserviceaccount.com",
    "universe_domain": "googleapis.com",
  };


  static Future<String?> _getAccessToken() async {
    try {
      final accountCredentials = ServiceAccountCredentials.fromJson(
        _serviceAccountJson,
      );
      final scopes = ['https://www.googleapis.com/auth/firebase.messaging'];
      final client = await clientViaServiceAccount(accountCredentials, scopes);
      return client.credentials.accessToken.data;
    } catch (e) {
      debugPrint("Error getting access token: $e");
      return null;
    }
  }

  static Future<void> sendPushNotification({
    required String fcmToken, 
    required String title,
    required String body,
    required Map<String, String> data,
  }) async {
    final String? accessToken = await _getAccessToken();
    if (accessToken == null) return;

    final String projectId = _serviceAccountJson['project_id'];
    final String endpoint =
        'https://fcm.googleapis.com/v1/projects/$projectId/messages:send';

    try {
      await Dio().post(
        endpoint,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $accessToken',
          },
        ),
        data: {
          "message": {
            "token": fcmToken,
            "notification": {"title": title, "body": body},
            "data": data,
          },
        },
      );
      debugPrint("✅ Push Notification Sent Successfully!");
    } catch (e) {
      debugPrint("❌ Error sending push: $e");
    }
  }
}
