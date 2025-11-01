import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:kheet_amal/feature/profile/data/models/user_model.dart';
import 'package:kheet_amal/feature/profile/widgets/custom_text_feild.dart';


class EditProfileFormSection extends StatefulWidget {
  final UserModel user;
  final bool isLoading;
  final Function(UserModel updatedUser) onSave;

  const EditProfileFormSection({
    super.key,
    required this.user,
    required this.isLoading,
    required this.onSave,
  });

  @override
  State<EditProfileFormSection> createState() => _EditProfileFormSectionState();
}

class _EditProfileFormSectionState extends State<EditProfileFormSection> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _phoneController;
  late final TextEditingController _locationController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.user.name);
    _emailController = TextEditingController(text: widget.user.email);
    _phoneController = TextEditingController(text: widget.user.phone);
    _locationController =
        TextEditingController(text: widget.user.address ?? '');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          // الاسم
          CustomTextEditField(
            label: "name".tr(),
            controller: _nameController,
            validator: (v) =>
                v == null || v.trim().isEmpty ? "enter_name".tr() : null,
          ),

          // الإيميل (للقراءة فقط)
          CustomTextEditField(
            label: "email".tr(),
            controller: _emailController,
            readOnly: true,
            fillColor: Colors.grey[200],
          ),

          // رقم الهاتف
          CustomTextEditField(
            label: "phone".tr(),
            controller: _phoneController,
            validator: (v) =>
                v == null || v.trim().isEmpty ? "enter_phone".tr() : null,
          ),

          // العنوان
          CustomTextEditField(
            label: "location".tr(),
            controller: _locationController,
          ),

          SizedBox(height: 20.h),

          // زر الحفظ
          ElevatedButton(
            onPressed: widget.isLoading
                ? null
                : () {
                    if (!_formKey.currentState!.validate()) return;

                    final updatedUser = UserModel(
                      id: widget.user.id,
                      name: _nameController.text.trim(),
                      email: widget.user.email,
                      phone: _phoneController.text.trim(),
                      address: _locationController.text.trim(),
                      profilePictureUrl: widget.user.profilePictureUrl,
                    );

                    widget.onSave(updatedUser);
                  },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.r),
              ),
              padding: EdgeInsets.symmetric(vertical: 12.h),
              elevation: 2,
            ),
            child: widget.isLoading
                ? const SizedBox(
                    height: 22,
                    width: 22,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2.0,
                    ),
                  )
                : Text(
                    "save_changes".tr(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
