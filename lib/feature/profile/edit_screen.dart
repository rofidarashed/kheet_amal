import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import 'widgets/full_screen_loader.dart';

class EditScreen extends StatefulWidget {
  const EditScreen({super.key});

  @override
  _EditScreenState createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController(
    text: "بندق ساما",
  );
  final TextEditingController emailController = TextEditingController(
    text: "bondoksama@gmail.com",
  );
  final TextEditingController phoneController = TextEditingController(
    text: "01011111111",
  );
  final TextEditingController locationController = TextEditingController(
    text: "القاهرة الجديدة",
  );

  bool isLoading = false;
  File? _imageFile;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  void saveChanges() async {
    if (_formKey.currentState!.validate()) {
      setState(() => isLoading = true);
      await Future.delayed(const Duration(seconds: 2));
      setState(() => isLoading = false);

      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          Future.delayed(const Duration(seconds: 3), () {
            if (Navigator.canPop(context)) {
              Navigator.of(context, rootNavigator: true).pop();
            }
          });
          return AlertDialog(
            insetPadding: EdgeInsets.symmetric(
              horizontal: 40.w,
              vertical: 24.h,
            ),
            contentPadding: EdgeInsets.all(24.w),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.r),
            ),
            content: SizedBox(
              width: 300.w,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.check_circle, color: Colors.green, size: 80.sp),
                  SizedBox(height: 20.h),
                  Text(
                    "save_success".tr(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 26.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    "data_updated".tr(),
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 22.sp, color: Colors.black87),
                  ),
                ],
              ),
            ),
          );
        },
      );
    }
  }

  InputDecoration customDecoration() {
    return InputDecoration(
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.r),
        borderSide: const BorderSide(color: Colors.blue),
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),
    );
  }

  Widget buildField(
    String label,
    TextEditingController controller, {
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          label,
          textAlign: TextAlign.right,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24.sp),
        ),
        SizedBox(height: 5.h),
        TextFormField(
          controller: controller,
          textAlign: TextAlign.right,
          decoration: customDecoration(),
          validator: validator,
          style: TextStyle(fontSize: 18.sp),
        ),
        SizedBox(height: 15.h),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("edit_account".tr(), style: TextStyle(fontSize: 24.sp)),
        leading: const BackButton(),
        backgroundColor: Colors.grey[200],
      ),
      body: Stack(
        children: [
          Container(
            color: Colors.grey[200],
            child: Padding(
              padding: EdgeInsets.all(16.w),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    Center(
                      child: Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          CircleAvatar(
                            radius: 55.r,
                            backgroundColor: Colors.grey[300],
                            backgroundImage: _imageFile != null
                                ? FileImage(_imageFile!)
                                : null,
                            child: _imageFile == null
                                ? Icon(
                                    Icons.person,
                                    size: 60.sp,
                                    color: Colors.grey,
                                  )
                                : null,
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: InkWell(
                              onTap: _pickImage,
                              child: Container(
                                decoration: const BoxDecoration(
                                  color: Colors.orange,
                                  shape: BoxShape.circle,
                                ),
                                padding: EdgeInsets.all(8.w),
                                child: Icon(
                                  Icons.camera_alt,
                                  color: Colors.white,
                                  size: 22.sp,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20.h),

                    buildField(
                      "name".tr(),
                      nameController,
                      validator: (v) => v!.isEmpty ? "enter_name".tr() : null,
                    ),
                    buildField(
                      "email".tr(),
                      emailController,
                      validator: (v) => v!.isEmpty ? "enter_email".tr() : null,
                    ),
                    buildField(
                      "phone".tr(),
                      phoneController,
                      validator: (v) => v!.isEmpty ? "enter_phone".tr() : null,
                    ),
                    buildField("location".tr(), locationController),

                    SizedBox(height: 10.h),
                    ElevatedButton(
                      onPressed: isLoading ? null : saveChanges,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        padding: EdgeInsets.symmetric(vertical: 10.h),
                      ),
                      child: Text(
                        "save_changes".tr(),
                        style: TextStyle(color: Colors.white, fontSize: 24.sp),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (isLoading) const FullScreenLoader(),
        ],
      ),
    );
  }
}
