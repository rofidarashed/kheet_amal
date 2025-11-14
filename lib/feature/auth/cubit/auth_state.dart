import 'package:firebase_auth/firebase_auth.dart';
import 'package:kheet_amal/feature/profile/data/models/user_model.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final User user;
  AuthSuccess(this.user);
}

class AuthFailure extends AuthState {
  final String error;
  AuthFailure(this.error);
}

class AuthLoggedOut extends AuthState {}

class AuthUserLoaded extends AuthState {
  final UserModel userModel;
  AuthUserLoaded(this.userModel);
}
