import 'dart:io';

abstract class EditProfileState {
  const EditProfileState();
}

class EditProfileInitial extends EditProfileState {}

class EditProfileLoading extends EditProfileState {}

class EditProfileSuccess extends EditProfileState {}

class EditProfileError extends EditProfileState {
  final String message;
  const EditProfileError(this.message);
}

class EditProfileImageSelected extends EditProfileState {
  final File image;
  const EditProfileImageSelected(this.image);
}
