abstract class SavedReportsState {}

final class SavedReportsInitial extends SavedReportsState {}

final class SavedReportsFailed extends SavedReportsState {
  final String message;

  SavedReportsFailed({required this.message});
}

final class SavedReportsToggled extends SavedReportsState {
  final String reportId;
  final bool isSaved;
  SavedReportsToggled({required this.reportId, required this.isSaved});
}

final class SavedReportsCountFetched extends SavedReportsState {
  final int count;
  SavedReportsCountFetched({required this.count});
}