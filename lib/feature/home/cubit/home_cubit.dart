import 'dart:async'; 
import 'package:bloc/bloc.dart';
import 'package:kheet_amal/feature/home/cubit/home_state.dart';
import '../data/repositories/report_repository.dart';

class HomeCubit extends Cubit<HomeState> {
  final ReportRepository _repository;
  StreamSubscription? _reportsSubscription; 

  HomeCubit(this._repository) : super(HomeState.initial());

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
}