import 'package:kheet_amal/feature/notification/model/notification_model.dart';

abstract class NotificationState {}

class NotificationInitial extends NotificationState {}

class NotificationLoading extends NotificationState {}

class NotificationLoaded extends NotificationState {
  final List<NotificationModel> notifications;
  final bool isEnabled;
  NotificationLoaded({required this.notifications, required this.isEnabled});
}

class NotificationError extends NotificationState {
  final String message;
  NotificationError(this.message);
}
