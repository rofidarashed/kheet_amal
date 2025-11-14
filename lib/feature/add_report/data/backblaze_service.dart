// import 'dart:convert';
import 'dart:convert';
import 'dart:io';
import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';

class BackblazeService {
  final _dio = Dio();

  static const _keyId = '003c5e49060e5980000000001';
  static const _applicationKey = 'K003XYSe4Gx40iX+oPZWabUX9qoM0js';
  static const _bucketId = 'dcc57ee459d066709e950918';
  static const _bucketName = 'kheet-amal-assets';

  static const _defaultImage =
      'https://firebasestorage.googleapis.com/v0/b/demo-app.appspot.com/o/defaults%2Fdefault_image.jpg?alt=media';

  /// Authorize Backblaze account
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

  /// Get upload URL
  Future<Map<String, dynamic>?> _getUploadUrl(
      String apiUrl, String authToken) async {
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

  /// Upload image and return **PUBLIC URL**
  Future<String> uploadImage(File? imageFile) async {
    if (imageFile == null) return _defaultImage;

    try {
      // Step 1: Authorize
      final authData = await _authorizeAccount();
      if (authData == null) return _defaultImage;

      final apiUrl = authData['apiUrl'];
      final authToken = authData['authorizationToken'];
      final downloadUrl = authData['downloadUrl'];

      // Step 2: Get upload URL
      final uploadData = await _getUploadUrl(apiUrl, authToken);
      if (uploadData == null) return _defaultImage;

      final uploadUrl = uploadData['uploadUrl'];
      final uploadAuthToken = uploadData['authorizationToken'];

      // Step 3: Prepare file
      final fileName = 'reports/${DateTime.now().millisecondsSinceEpoch}.jpg';
      final bytes = await imageFile.readAsBytes();
      final sha1Hash = sha1.convert(bytes).toString();

      // Step 4: Upload to Backblaze
      final response = await _dio.post(
        uploadUrl,
        data: bytes,
        options: Options(
          headers: {
            'Authorization': uploadAuthToken,
            'X-Bz-File-Name': Uri.encodeComponent(fileName),
            'Content-Type': 'image/jpeg',
            'X-Bz-Content-Sha1': sha1Hash,
          },
        ),
      );

      if (response.statusCode == 200) {
        // ✅ This is the **Public Direct Link**
        final publicUrl = 'https://f003.backblazeb2.com/file/$_bucketName/$fileName';
        return publicUrl;
      } else {
        print('⚠️ Upload failed: ${response.statusCode}');
        return _defaultImage;
      }
    } catch (e) {
      print('❌ Upload error: $e');
      return _defaultImage;
    }
  }
}
