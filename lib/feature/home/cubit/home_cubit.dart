import 'dart:async'; 
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kheet_amal/feature/home/cubit/home_state.dart';
import 'package:kheet_amal/feature/home/data/models/report_model.dart';
import '../data/repositories/report_repository.dart';

class HomeCubit extends Cubit<HomeState> {
  final ReportRepository _repository;
  StreamSubscription? _reportsSubscription; 

  HomeCubit(this._repository) : super(HomeState.initial());
  final user = FirebaseAuth.instance.currentUser!;

  void loadReports() {
    emit(state.copyWith(isLoading: true));

    _reportsSubscription?.cancel();

    _reportsSubscription = _repository.getReportsStream().listen(
      (reports) {
        emit(state.copyWith(isLoading: false, reports: reports));
      },
      onError: (error) {
        print("Stream Error: $error");
        emit(state.copyWith(isLoading: false));
      },
    );
  }

  @override
  Future<void> close() {
    _reportsSubscription?.cancel();
    return super.close();
  }
 Future<void> toggleLike(String reportId) async {
  final uid = user.uid;

  final reports = List<ReportModel>.from(state.reports);

  final index = reports.indexWhere((r) => r.id == reportId);
  if (index == -1) return;

  final report = reports[index];

  final wasLiked = report.isLiked;
  final previousLikes = report.likes;

  try {
    if (wasLiked) {
      report.isLiked = false;
      report.likes--;
      report.likedBy.remove(uid);

      emit(state.copyWith(reports: reports));

      await _repository.unlikeReport(
        postId: reportId,
        userId: uid,
      );
    } else {
      report.isLiked = true;
      report.likes++;
      if (!report.likedBy.contains(uid)) {
        report.likedBy.add(uid);
      }

      emit(state.copyWith(reports: reports));

      await _repository.likeReport(
        postId: reportId,
        userId: uid,
      );
    }
  } catch (e) {
    report.isLiked = wasLiked;
    report.likes = previousLikes;

    emit(state.copyWith(reports: reports));
  }
}

}