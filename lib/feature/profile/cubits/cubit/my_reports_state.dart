import 'package:kheet_amal/feature/home/data/models/report_model.dart';

abstract class MyReportsState {}

class MyReportsInitial extends MyReportsState {}

class MyReportsLoading extends MyReportsState {}

class MyReportsLoaded extends MyReportsState {
  final List<ReportModel> reports;
  
  MyReportsLoaded({required this.reports});
}

class MyReportsError extends MyReportsState {
  final String message;
  
  MyReportsError({required this.message});
}