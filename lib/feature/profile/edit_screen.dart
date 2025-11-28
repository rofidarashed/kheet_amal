import 'dart:io';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:kheet_amal/core/utils/app_colors.dart';
import 'package:kheet_amal/feature/profile/data/models/user_model.dart';
import 'cubits/edit_profile_cubit/edit_profile_cubit.dart';
import 'cubits/edit_profile_cubit/edit_profile_state.dart';
import 'data/edit_profile_repo.dart';
import 'widgets/full_screen_loader.dart';
import 'widgets/edit_profile_form_section.dart';

class EditScreen extends StatelessWidget {
  final UserModel user;
  const EditScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<EditProfileCubit>(
      create: (_) => EditProfileCubit(EditProfileRepo()),
      child: BlocConsumer<EditProfileCubit, EditProfileState>(
        listener: (context, state) {
          if (state is EditProfileSuccess) {
            AwesomeDialog(
              context: context,
              dialogType: DialogType.success,
              animType: AnimType.rightSlide,
              title: 'profile_updated'.tr(),
              desc: 'changes_saved'.tr(),
              btnOkOnPress: () {
                Navigator.pop(context, true);
              },
            ).show();
          } else if (state is EditProfileError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('حدث خطأ: ${state.message}')),
            );
          }
        },
        builder: (context, state) {
          final cubit = context.read<EditProfileCubit>();
          final isLoading = state is EditProfileLoading;
          File? selectedImage;
          if (state is EditProfileImageSelected) selectedImage = state.image;
          ImageProvider? avatarImage;
          if (selectedImage != null) {
            avatarImage = FileImage(selectedImage);
          } else if (user.profilePictureUrl != null &&
              user.profilePictureUrl!.isNotEmpty) {
            avatarImage = NetworkImage(user.profilePictureUrl!);
          } else {
            avatarImage = null;
          }
          return Scaffold(
            appBar: AppBar(
              title: Text(
                "edit_account".tr(),
                style: TextStyle(fontSize: 22.sp),
              ),
              leading: const BackButton(),
              backgroundColor: Colors.grey[200],
              elevation: 0,
            ),
            body: Stack(
              children: [
                Container(
                  color: Colors.grey[200],
                  child: Padding(
                    padding: EdgeInsets.all(16.w),
                    child: Column(
                      children: [
                        Center(
                          child: Column(
                            children: [
                              Stack(
                                alignment: Alignment.bottomRight,
                                children: [
                                  CircleAvatar(
                                    radius: 55.r,
                                    backgroundColor: Colors.grey[200],
                                    backgroundImage: avatarImage,
                                    child: avatarImage == null
                                        ? Image.asset("assets/images/profile_pict.png",
                                            width: 112.w,
                                            height: 112.h,
                                          )
                                        : null,
                                  ),
                                  Positioned(
                                    bottom: 0,
                                    right: 0,
                                    child: GestureDetector(
                                      onTap: () => cubit.selectImage(),
                                      child: Container(
                                        decoration: const BoxDecoration(
                                          color: AppColors.secondaryColor,
                                          shape: BoxShape.circle,
                                        ),
                                        padding:  EdgeInsets.all(8.w),
                                        child: const Icon(
                                          Icons.camera_alt,
                                          color: AppColors.white,
                                          size: 22,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 18.h),
                            ],
                          ),
                        ),
                        Expanded(
                          child: EditProfileFormSection(
                            user: user,
                            isLoading: isLoading,
                            onSave: (updatedUser) {
                              cubit.updateUserProfile(updatedUser);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                if (isLoading) const FullScreenLoader(),
              ],
            ),
          );
        },
      ),
    );
  }
}
