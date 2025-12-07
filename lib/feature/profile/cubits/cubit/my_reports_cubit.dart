import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kheet_amal/feature/home/data/models/report_model.dart';
import 'package:kheet_amal/feature/profile/data/my_reports_repo.dart';

class MyReportsCubit extends Cubit<MyReportsState> {
  final MyReportsRepository _repository;
  int reportsCount = 0;
  bool isLoading = false;
  StreamSubscription? _reportsSubscription;
  
  MyReportsCubit(this._repository) : super(MyReportsInitial());

  Future<void> loadReports() async {
    try {
      isLoading = true;
      emit(MyReportsLoading()); 
      
      _reportsSubscription?.cancel(); 
      
      _reportsSubscription = _repository.getMyReportsStream().listen(
        (reports) {
          isLoading = false;
          reportsCount = reports.length;
          emit(MyReportsLoaded(reports: reports));
        },
        onError: (error) {
          isLoading = false;
          emit(MyReportsError(message: error.toString()));
        },
      );
    } catch (e) {
      isLoading = false;
      emit(MyReportsError(message: e.toString()));
    }
  }

  Future<void> deleteReport(String reportId) async {
    try {
      isLoading = true;
      emit(MyReportsLoading());
      
      final currentState = state;
      List<ReportModel> currentReports = [];
      
      if (currentState is MyReportsLoaded) {
        currentReports = currentState.reports;
      }
      
      await _repository.deleteReportWithImage(reportId);
      
      final newList = currentReports.where((report) => report.id != reportId).toList();
      reportsCount = newList.length;
      isLoading = false;
      
      emit(MyReportsLoaded(reports: newList));
      
    } catch (e) {
      isLoading = false;
      emit(MyReportsError(message: e.toString()));
      loadReports();
    }
  }

  @override
  Future<void> close() {
    _reportsSubscription?.cancel();
    return super.close();
  }
}

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