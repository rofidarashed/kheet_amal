import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:kheet_amal/core/utils/shared_prefs_helper.dart';
import 'package:kheet_amal/feature/profile/data/models/user_model.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  bool value = false;

  AuthCubit() : super(AuthInitial()) {
    SharedPrefsHelper.init();
  }

  Future<void> registerUser({
    // required String uid,
    required String email,
    required String password,
    required String name,
    required String phone,
    String? address,
  }) async {
    emit(AuthLoading());
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final uid = userCredential.user!.uid;

      await _firestore.collection('users').doc(uid).set({
        'uid': uid,
        'name': name,
        'phone': phone,
        'email': email,
        'createdAt': DateTime.now(),
        'address': address,
      });
      await SharedPrefsHelper.saveUserLocally(userCredential.user);

      emit(AuthSuccess(userCredential.user!));
    } on FirebaseAuthException catch (e) {
      emit(AuthFailure(_handleError(e)));
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> loginUser({
    required String email,
    required String password,
  }) async {
    emit(AuthLoading());
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      await SharedPrefsHelper.saveUserLocally(userCredential.user);
      emit(AuthSuccess(userCredential.user!));
    } on FirebaseAuthException catch (e) {
      emit(AuthFailure(_handleError(e)));
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> resetPassword(String email) async {
    emit(AuthLoading());
    try {
      await _auth.sendPasswordResetEmail(email: email);
      emit(AuthInitial());
    } on FirebaseAuthException catch (e) {
      emit(AuthFailure(_handleError(e)));
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> logout() async {
    try {
      await _auth.signOut();
      await SharedPrefsHelper.clearUserLocally();
      emit(AuthLoggedOut());

    } catch (_) {
    }
  }

  Future<UserModel?> fetchUserData() async {
    emit(AuthLoading());
    try {
      final uid = _auth.currentUser?.uid;
      if (uid == null) {
        emit(AuthFailure('No authenticated user'.toString()));
        return null;
      }

      final doc = await _firestore.collection('users').doc(uid).get();
      if (!doc.exists) {
        emit(AuthFailure('User document not found'));
        return null;
      }

      final userModel = UserModel.fromMap(doc.id, doc.data()!);
      emit(AuthUserLoaded(userModel));
      return userModel;
    } catch (e) {
      emit(AuthFailure(e.toString()));
      return null;
    }
}

  String _handleError(FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
        return 'user-not-found'.tr();
      case 'wrong-password':
        return 'wrong-password'.tr();
      case 'email-already-in-use':
        return 'email-already-in-use'.tr();
      case 'weak-password':
        return 'weak-password'.tr();
      case 'invalid-email':
        return 'invalid-email'.tr();
      default:
        return e.message ?? 'invalid-email'.tr();
    }
  }

  void toggleValue() {
    value = !value;
    emit(AuthInitial());
  }
}
