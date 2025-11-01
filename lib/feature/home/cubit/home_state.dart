import 'package:kheet_amal/feature/home/data/models/report_model.dart';

class HomeState {
  final bool isLoading;
  final List<ReportModel> reports;

  HomeState({required this.isLoading, required this.reports});

  factory HomeState.initial() => HomeState(isLoading: false, reports: []);

  HomeState copyWith({bool? isLoading, List<ReportModel>? reports}) {
    return HomeState(
      isLoading: isLoading ?? this.isLoading,
      reports: reports ?? this.reports,
    );
  }
}
