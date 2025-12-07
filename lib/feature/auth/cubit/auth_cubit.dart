import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
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

  Future<String?> _getFcmToken() async {
    try {
      return await FirebaseMessaging.instance.getToken();
    } catch (e) {
      return null;
    }
  }

  Future<void> registerUser({
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

      final user = userCredential.user!;
      await user.sendEmailVerification();

      String? token = await _getFcmToken();

      await _firestore.collection('users').doc(user.uid).set({
        'uid': user.uid,
        'name': name,
        'phone': phone,
        'email': email,
        'createdAt': DateTime.now(),
        'address': address,
        'fcmToken': token, 
      });

      emit(AuthFailure("email-verification-sent"));
    } on FirebaseAuthException catch (e) {
      if (e.code == "email-already-in-use") {
        emit(AuthFailure("email-already-in-use"));
      } else {
        emit(AuthFailure(_handleError(e)));
      }
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
      final user = userCredential.user!;

      String? token = await _getFcmToken();
      if (token != null) {
        await _firestore.collection('users').doc(user.uid).set({
          'fcmToken': token,
        }, SetOptions(merge: true));
      }

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
      final querySnapshot = await _firestore
          .collection('users')
          .where('email', isEqualTo: email)
          .get();

      if (querySnapshot.docs.isEmpty) {
        emit(AuthFailure("no_user_with_email".tr()));
        return;
      }
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
    } catch (_) {}
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
      case 'invalid-credential':
        return e.code;
      default:
        return e.message ?? 'invalid-email'.tr();
    }
  }

  void toggleValue() {
    value = !value;
    emit(AuthInitial());
  }
}
