import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';

class BackblazeService {
  final _dio = Dio();

  static const _keyId = '003c5e49060e5980000000001';
  static const _applicationKey = 'K003XYSe4Gx40iX+oPZWabUX9qoM0js';
  static const _bucketId = 'dcc57ee459d066709e950918';
  static const _defaultImage =
      'https://firebasestorage.googleapis.com/v0/b/demo-app.appspot.com/o/defaults%2Fdefault_image.jpg?alt=media';

  /// 🔹 Step 1: Authorize Backblaze account
  Future<Map<String, dynamic>?> _authorizeAccount() async {
    final basicAuth =
        'Basic ${base64Encode(utf8.encode("$_keyId:$_applicationKey"))}';
    try {
      print('📡 Authorizing Backblaze account...');
      final response = await _dio.get(
        'https://api.backblazeb2.com/b2api/v2/b2_authorize_account',
        options: Options(headers: {'Authorization': basicAuth}),
      );
      print('✅ Authorization success!');
      print('🧾 Auth data: ${response.data}');
      return response.data;
    } catch (e) {
      print('❌ Authorization failed: $e');
      return null;
    }
  }

  /// 🔹 Step 2: Get upload URL
  Future<Map<String, dynamic>?> _getUploadUrl(
      String apiUrl, String authToken) async {
    try {
      print('📡 Getting upload URL...');
      final response = await _dio.post(
        '$apiUrl/b2api/v2/b2_get_upload_url',
        data: {'bucketId': _bucketId},
        options: Options(headers: {'Authorization': authToken}),
      );
      print('✅ Got upload URL!');
      print('🧾 Upload data: ${response.data}');
      return response.data;
    } catch (e) {
      print('❌ Failed to get upload URL: $e');
      return null;
    }
  }

  /// 🔹 Step 3: Upload image
  Future<String> uploadImage(File? imageFile) async {
    if (imageFile == null) {
      print('⚠️ No image selected, returning default image.');
      return _defaultImage;
    }

    try {
      // 1️⃣ Authorize
      final authData = await _authorizeAccount();
      if (authData == null) {
        print('❌ Authorization data is null.');
        return _defaultImage;
      }

      final apiUrl = authData['apiUrl'];
      final authToken = authData['authorizationToken'];
      final downloadUrl = authData['downloadUrl'];

      print('🔑 Auth token (account-level): $authToken');
      print('🌐 API URL: $apiUrl');

      // 2️⃣ Get upload URL
      final uploadData = await _getUploadUrl(apiUrl, authToken);
      if (uploadData == null) {
        print('❌ Upload data is null.');
        return _defaultImage;
      }

      final uploadUrl = uploadData['uploadUrl'];
      final uploadAuthToken = uploadData['authorizationToken'];

      print('📤 Upload URL: $uploadUrl');
      print('🔑 Upload token: $uploadAuthToken');

      // 3️⃣ Prepare file
      final fileName = 'reports/${DateTime.now().millisecondsSinceEpoch}.jpg';
      final bytes = await imageFile.readAsBytes();
      final sha1Hash = sha1.convert(bytes).toString();

      print('📦 File name: $fileName');
      print('📏 File size: ${bytes.length} bytes');
      print('🔐 SHA1 hash: $sha1Hash');

      // 4️⃣ Upload file
      final response = await _dio.post(
        uploadUrl,
        data: bytes,
        options: Options(
          headers: {
            'Authorization': uploadAuthToken,
            'X-Bz-File-Name': Uri.encodeComponent(fileName),
            'Content-Type': 'image/jpeg',
            'X-Bz-Content-Sha1': sha1Hash,
            'Content-Length': bytes.length.toString(), // ✅ fix here
          },
        ),
      );

      print('📨 Upload response status: ${response.statusCode}');
      print('🧾 Upload response data: ${response.data}');

      if (response.statusCode == 200) {
        print('✅ Uploaded successfully!');
        final uploadedUrl = '$downloadUrl/file/kheet-amal-assets/$fileName';
        print('🌍 File available at: $uploadedUrl');
        return uploadedUrl;
      } else {
        print('⚠️ Upload failed with status code: ${response.statusCode}');
        return _defaultImage;
      }
    } catch (e) {
      print('❌ Backblaze upload error: $e');
      return _defaultImage;
    }
  }
}
