import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kheet_amal/feature/add_report/data/backblaze_service.dart';
import 'package:kheet_amal/feature/profile/data/models/user_model.dart';
import '../../data/edit_profile_repo.dart';
import 'edit_profile_state.dart';

class EditProfileCubit extends Cubit<EditProfileState> {
  final EditProfileRepo _repo;
  final ImagePicker _picker = ImagePicker();
  final BackblazeService _backblazeService = BackblazeService();
  File? selectedImage;

  EditProfileCubit(this._repo) : super(EditProfileInitial());

  Future<void> selectImage() async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 85,
      );

      if (pickedFile != null) {
        selectedImage = File(pickedFile.path);
        emit(EditProfileImageSelected(selectedImage!));
      }
    } catch (e) {
      emit(const EditProfileError('Failed to pick image'));
    }
  }

  Future<void> updateUserProfile(UserModel user) async {
    emit(EditProfileLoading());
    try {
      String? imageUrl;

      if (selectedImage != null) {
        final uploadedUrl = await _backblazeService.uploadImage(selectedImage!);

        if (uploadedUrl != null) {
          final uri = Uri.parse(uploadedUrl);
          final fileName = uri.pathSegments.last;
          final folder = uri.pathSegments[uri.pathSegments.length - 2];
          final fileKey = '$folder/$fileName';

          final secureUrl = await BackblazeService.getTemporaryImageUrl(
            fileKey,
          );
          imageUrl = secureUrl ?? uploadedUrl;
        }
      }

      await _repo.updateUserProfile(updatedUser: user, imageUrl: imageUrl);

      selectedImage = null;
      emit(EditProfileSuccess());
    } catch (e) {
      emit(EditProfileError(e.toString()));
    }
  }
}
