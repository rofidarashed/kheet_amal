import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kheet_amal/feature/notification/cubit/notification_state.dart';
import 'package:kheet_amal/feature/notification/model/notification_model.dart';

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit() : super(NotificationInitial());

  StreamSubscription? _subscription;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> initNotifications() async {
    try {
      emit(NotificationLoading());
      final user = _auth.currentUser;

      if (user == null) {
        emit(NotificationError("User not logged in"));
        return;
      }

      final userDoc = await _firestore.collection('users').doc(user.uid).get();
      bool isEnabled = true;
      if (userDoc.exists &&
          userDoc.data()!.containsKey('notificationsEnabled')) {
        isEnabled = userDoc.data()!['notificationsEnabled'];
      }

      _subscription = _firestore
          .collection('users')
          .doc(user.uid)
          .collection('notifications')
          .orderBy('createdAt', descending: true)
          .snapshots()
          .listen(
            (snapshot) {
              final notifications = snapshot.docs
                  .map((doc) => NotificationModel.fromFirestore(doc))
                  .toList();

              emit(
                NotificationLoaded(
                  notifications: notifications,
                  isEnabled: isEnabled,
                ),
              );
            },
            onError: (error) {
              emit(NotificationError(error.toString()));
            },
          );
    } catch (e) {
      emit(NotificationError(e.toString()));
    }
  }

  Future<void> toggleNotifications(bool value) async {
    final currentState = state;
    if (currentState is NotificationLoaded) {
      emit(
        NotificationLoaded(
          notifications: currentState.notifications,
          isEnabled: value,
        ),
      );

      try {
        final user = _auth.currentUser;
        if (user != null) {
          await _firestore.collection('users').doc(user.uid).set({
            'notificationsEnabled': value,
          }, SetOptions(merge: true));
        }
      } catch (e) {
        emit(
          NotificationLoaded(
            notifications: currentState.notifications,
            isEnabled: !value,
          ),
        );
      }
    }
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
