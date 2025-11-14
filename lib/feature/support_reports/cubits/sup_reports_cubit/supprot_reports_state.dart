abstract class SupportReportsState {}

final class SupportReportsInitial extends SupportReportsState {}

final class SupportReportsFailed extends SupportReportsState {
  final String message;
  SupportReportsFailed({required this.message});
}

final class SupportReportsToggled extends SupportReportsState {
  final String reportId;
  final bool isSupported;
  SupportReportsToggled({required this.reportId, required this.isSupported});
}
