import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:crypto/crypto.dart';

class BackblazeService {
  final _dio = Dio();

  static const _keyId = '003c5e49060e5980000000001';
  static const _applicationKey = 'K003XYSe4Gx40iX+oPZWabUX9qoM0js';
  static const _bucketId = 'dcc57ee459d066709e950918';
  static const _defaultImage =
      'https://firebasestorage.googleapis.com/v0/b/demo-app.appspot.com/o/defaults%2Fdefault_image.jpg?alt=media';

  Future<Map<String, dynamic>?> _authorizeAccount() async {
    final basicAuth =
        'Basic ${base64Encode(utf8.encode("$_keyId:$_applicationKey"))}';
    try {
      final response = await _dio.get(
        'https://api.backblazeb2.com/b2api/v2/b2_authorize_account',
        options: Options(headers: {'Authorization': basicAuth}),
      );
      return response.data;
    } catch (e) {
      print('❌ Authorization failed: $e');
      return null;
    }
  }

  Future<Map<String, dynamic>?> _getUploadUrl(String apiUrl, String authToken) async {
    try {
      final response = await _dio.post(
        '$apiUrl/b2api/v2/b2_get_upload_url',
        data: {'bucketId': _bucketId},
        options: Options(headers: {'Authorization': authToken}),
      );
      return response.data;
    } catch (e) {
      print('❌ Failed to get upload URL: $e');
      return null;
    }
  }

  Future<String> uploadImage(File? imageFile) async {
    if (imageFile == null) return _defaultImage;

    try {
      // 1️⃣ Get authorization info
      final authData = await _authorizeAccount();
      if (authData == null) return _defaultImage;

      final apiUrl = authData['apiUrl'];
      final authToken = authData['authorizationToken'];

      // 2️⃣ Get upload URL
      final uploadData = await _getUploadUrl(apiUrl, authToken);
      if (uploadData == null) return _defaultImage;

      final uploadUrl = uploadData['uploadUrl'];
      final uploadAuthToken = uploadData['authorizationToken'];

      // 3️⃣ Upload file
      final fileName = 'reports/${DateTime.now().millisecondsSinceEpoch}.jpg';
      final bytes = await imageFile.readAsBytes();

      final response = await _dio.post(
        uploadUrl,
        data: Stream.fromIterable([bytes]),
        options: Options(
          headers: {
            'Authorization': uploadAuthToken,
            'X-Bz-File-Name': Uri.encodeComponent(fileName),
            'Content-Type': 'image/jpeg',
            'X-Bz-Content-Sha1': sha1.convert(bytes).toString(),
          },
        ),
      );

      if (response.statusCode == 200) {
        print('✅ Uploaded successfully!');
        // بناء رابط التحميل
        final downloadUrl = authData['downloadUrl'];
        return '$downloadUrl/file/kheet-amal-assets/$fileName';
      } else {
        print('⚠️ Upload failed: ${response.statusCode}');
        return _defaultImage;
      }
    } catch (e) {
      print('❌ Backblaze upload error: $e');
      return _defaultImage;
    }
  }
}
