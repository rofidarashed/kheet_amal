import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

class AiService {

  static const String baseUrl = "https://advanced-age.loca.lt";

  static Future<File> getAssetFile(String assetPath) async {
    try {
      final byteData = await rootBundle.load(assetPath);
      final tempDir = await getTemporaryDirectory();
      final file = File('${tempDir.path}/${assetPath.split('/').last}');
      await file.writeAsBytes(byteData.buffer.asUint8List());
      return file;
    } catch (e) {
      print("Error loading asset: $e");
      throw e;
    }
  }

  static Future<File?> changeAge(File imageFile, bool makeOlder) async {
    try {
      final uri = Uri.parse("$baseUrl/transform_age");
      
      var request = http.MultipartRequest('POST', uri);
      
      // إضافة الصورة
      request.files.add(
        await http.MultipartFile.fromPath(
          'image', 
          imageFile.path
        )
      );
      

      request.fields['age'] = makeOlder ? 'older' : 'younger';
      
      print("🔄 جاري معالجة الصورة...");
      final response = await request.send();
      
      if (response.statusCode == 200) {
        print("✅ تمت المعالجة بنجاح!");
        
        final bytes = await response.stream.toBytes();
        final tempDir = await getTemporaryDirectory();
        final outputFile = File('${tempDir.path}/result_${DateTime.now().millisecondsSinceEpoch}.jpg');
        await outputFile.writeAsBytes(bytes);
        
        return outputFile;
      } else {
        print("❌ خطأ في الخادم: ${response.statusCode}");
        print("❌ Reason: ${response.reasonPhrase}");
        return null;
      }
    } catch (e) {
      print("❌ Error in changeAge: $e");
      return null;
    }
  }

}