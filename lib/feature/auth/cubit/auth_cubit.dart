import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:easy_localization/easy_localization.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  AuthCubit() : super(AuthInitial());

  // تسجيل مستخدم جديد مع الاسم ورقم الموبايل
  Future<void> registerUser({
    required String email,
    required String password,
    required String name,
    required String phone,
  }) async {
    emit(AuthLoading());
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final uid = userCredential.user!.uid;

      // حفظ البيانات الإضافية في Firestore
      await _firestore.collection('users').doc(uid).set({
        'name': name,
        'phone': phone,
        'email': email,
        'createdAt': DateTime.now(),
      });

      emit(AuthSuccess(userCredential.user!));
    } on FirebaseAuthException catch (e) {
      emit(AuthFailure(_handleError(e)));
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  // تسجيل الدخول
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
      emit(AuthSuccess(userCredential.user!));
    } on FirebaseAuthException catch (e) {
      emit(AuthFailure(_handleError(e)));
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  // إرسال رابط نسيت كلمة المرور
  Future<void> resetPassword(String email) async {
    emit(AuthLoading());
    try {
      await _auth.sendPasswordResetEmail(email: email);
      // لو حابة ممكن ترسلي رسالة نجاح خاصة
      emit(AuthInitial());
    } on FirebaseAuthException catch (e) {
      emit(AuthFailure(_handleError(e)));
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  // تسجيل الخروج
  Future<void> logout() async {
    await _auth.signOut();
    emit(AuthLoggedOut());
  }

  // جلب بيانات المستخدم من Firestore
  Future<Map<String, dynamic>?> getUserData() async {
    final uid = _auth.currentUser?.uid;
    if (uid == null) return null;

    final doc = await _firestore.collection('users').doc(uid).get();
    return doc.data();
  }

  // ترجمة الأخطاء
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
}
