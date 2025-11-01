import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kheet_amal/feature/profile/data/models/user_model.dart';

class EditProfileRepo {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<UserModel> updateUserProfile({
    required UserModel updatedUser,
    String? imageUrl,
  }) async {
    try {
      final user = _auth.currentUser;
      if (user == null) throw Exception('User not logged in');

      final updateData = updatedUser.copyWith(
        profilePictureUrl: imageUrl ?? updatedUser.profilePictureUrl,
      ).toMap();

      await _firestore.collection('users').doc(user.uid).update(updateData);

      final snapshot = await _firestore.collection('users').doc(user.uid).get();
      return UserModel.fromMap(user.uid, snapshot.data() ?? {});
    } catch (e, stack) {
      log('Error updating profile: $e\n$stack');
      rethrow;
    }
  }
}
