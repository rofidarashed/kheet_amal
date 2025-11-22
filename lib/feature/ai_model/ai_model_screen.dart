import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kheet_amal/core/utils/app_colors.dart';
import 'package:kheet_amal/feature/ai_model/logic.dart';
import 'package:kheet_amal/feature/ai_model/results_screen.dart';
import 'package:kheet_amal/feature/home/data/models/report_model.dart';
import 'package:shimmer/shimmer.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class AiScreen extends StatefulWidget {
  final ReportModel reportmodel;
  const AiScreen({super.key, required this.reportmodel});

  @override
  State<AiScreen> createState() => _AiScreenState();
}

class _AiScreenState extends State<AiScreen> {
  bool? selectedAgeType;
  bool isLoading = false;
  File? _localImageFile;

  final List<Map<String, dynamic>> ageOptions = [
    {'label': "younger".tr(), 'value': false},
    {'label': "older".tr(), 'value': true},
  ];

  @override
  void initState() {
    super.initState();
    _loadImage();
  }

  Future<void> _loadImage() async {
    final url = widget.reportmodel.imageUrl;
    if (url.startsWith('http')) {
      try {
        final response = await http.get(Uri.parse(url));
        if (response.statusCode == 200) {
          final dir = await getTemporaryDirectory();
          final file = File('${dir.path}/temp_image.jpg');
          await file.writeAsBytes(response.bodyBytes);
          setState(() {
            _localImageFile = file;
          });
        } else {
          print('Error downloading image: ${response.statusCode}');
        }
      } catch (e) {
        print('Exception downloading image: $e');
      }
    }
  }

  Future<void> sendImage() async {
    if (selectedAgeType == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("choose_age_type".tr())),
      );
      return;
    }

    setState(() => isLoading = true);

    try {
      final file = _localImageFile ?? File(widget.reportmodel.imageUrl);
      final resultFile = await AiService.changeAge(file, selectedAgeType!);

      setState(() => isLoading = false);

      if (resultFile != null && resultFile.existsSync()) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ResultScreen(resultFile: resultFile),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("processing_failed".tr())),
        );
      }
    } catch (e) {
      setState(() => isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("error_occurred".tr())),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text(
          "age_transform_title".tr(),
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 32.sp,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Container(
                  width: 280.w,
                  height: 280.h,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20.r),
                    child: _buildImage(),
                  ),
                ),
              ),

              SizedBox(height: 30.h),

              Text(
                "choose_transformation".tr(),
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[800],
                ),
              ),

              SizedBox(height: 24.h),

              Wrap(
                spacing: 25,
                runSpacing: 15,
                children: ageOptions.map((option) {
                  final isSelected = selectedAgeType == option['value'];
                  return GestureDetector(
                    onTap: () =>
                        setState(() => selectedAgeType = option['value']),
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 42.w, vertical: 12.h),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color:
                            isSelected ? Colors.lightBlue[100] : Colors.white,
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 6,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Text(
                        option['label'],
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),

              SizedBox(height: 42.h),

              Container(
                width: 350.w,
                height: 55.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  gradient: const LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      AppColors.magentaviolet,
                      AppColors.royalblue,
                    ],
                  ),
                ),
                child: ElevatedButton(
                  onPressed: isLoading ? null : sendImage,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.r),
                    ),
                  ),
                  child: isLoading
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 20.w,
                              height: 20.h,
                              child: const CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.white),
                              ),
                            ),
                            SizedBox(width: 12.w),
                            Shimmer.fromColors(
                              baseColor: Colors.white,
                              highlightColor: Colors.yellow,
                              child: const Text("Processing..."),
                            ),
                          ],
                        )
                      : Text(
                          "apply_transformation".tr(),
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                ),
              ),

              SizedBox(height: 24.h),

              if (selectedAgeType == null)
                Text(
                  "please_choose_option".tr(),
                  style: TextStyle(
                    color: AppColors.hintTextColor,
                    fontSize: 18.sp,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImage() {
    if (_localImageFile != null && _localImageFile!.existsSync()) {
      return Image.file(
        _localImageFile!,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => _errorWidget(),
      );
    }

    final url = widget.reportmodel.imageUrl;
    if (url.startsWith("assets")) {
      return Image.asset(
        url,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => _errorWidget(),
      );
    }

    return _errorWidget();
  }

  Widget _errorWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.error, color: Colors.red, size: 50),
        const SizedBox(height: 10),
        Text(
          "image_load_error".tr(),
          style: const TextStyle(color: Colors.red),
        ),
      ],
    );
  }
}
