import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kheet_amal/feature/home/data/models/report_model.dart';
import 'package:kheet_amal/feature/profile/data/my_reports_repo.dart';

class MyReportsCubit extends Cubit<List<ReportModel>> {
  final MyReportsRepository _repository;
  
  MyReportsCubit(this._repository) : super([]);

  void loadReports() {
    _repository.getMyReportsStream().listen((reports) {
      emit(reports);
    });
  }

  void deleteReport(String reportId) {
    // Optimistically remove from UI
    final newList = state.where((report) => report.id != reportId).toList();
    emit(newList);

    // Delete from backend
    _repository.deleteReportWithImage(reportId);
  }
}