import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import '../models/report_model.dart';

class ReportRepository {
  final _firestore = FirebaseFirestore.instance;
  final _dio = Dio();

  static const _keyId = '003c5e49060e5980000000001';
  static const _applicationKey = 'K003XYSe4Gx40iX+oPZWabUX9qoM0js';

  Future<String?> _getTemporaryImageUrl(String fileName) async {
    try {
      final basicAuth =
          'Basic ${base64Encode(utf8.encode("$_keyId:$_applicationKey"))}';
      final authResponse = await _dio.get(
        'https://api.backblazeb2.com/b2api/v2/b2_authorize_account',
        options: Options(headers: {'Authorization': basicAuth}),
      );

      final apiUrl = authResponse.data['apiUrl'];
      final authToken = authResponse.data['authorizationToken'];

      final response = await _dio.post(
        '$apiUrl/b2api/v2/b2_get_download_authorization',
        data: {
          'bucketId': 'dcc57ee459d066709e950918',
          'fileNamePrefix': fileName,
          'validDurationInSeconds': 3600,
        },
        options: Options(headers: {'Authorization': authToken}),
      );

      final downloadAuthToken = response.data['authorizationToken'];
      final downloadUrl = authResponse.data['downloadUrl'];
      final fileUrl =
          '$downloadUrl/file/kheet-amal-assets/$fileName?Authorization=$downloadAuthToken';

      return fileUrl;
    } catch (e) {
      print('OOO Failed to get temporary image URL: $e');
      return null;
    }
  }

  Future<List<ReportModel>> fetchReports() async {
    try {
      final snapshot = await _firestore
          .collection('reports')
          .orderBy('createdAt', descending: true)
          .get();

      final reports = <ReportModel>[];

      for (final doc in snapshot.docs) {
        final data = doc.data();

        String imageUrl = data['imageUrl'] ?? '';
        if (imageUrl.contains('reports/')) {
          final fileName = imageUrl.split('reports/').last;
          final secureUrl = await _getTemporaryImageUrl('reports/$fileName');
          if (secureUrl != null) imageUrl = secureUrl;
        }

        reports.add(
          ReportModel.fromMap(doc.id, {...data, 'imageUrl': imageUrl}),
        );
      }

      return reports;
    } catch (e) {
      print('OOO Fetch reports error: $e');
      return [];
    }
  }
}
