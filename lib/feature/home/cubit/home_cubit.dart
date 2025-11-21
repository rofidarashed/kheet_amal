import 'package:bloc/bloc.dart';
import 'package:kheet_amal/feature/home/cubit/home_state.dart';
import '../data/repositories/report_repository.dart';

class HomeCubit extends Cubit<HomeState> {
  final ReportRepository _repository;
  HomeCubit(this._repository) : super(HomeState.initial());

  Future<void> loadReports() async {
    emit(state.copyWith(isLoading: true));
    final reports = await _repository.fetchReports();
    emit(state.copyWith(isLoading: false, reports: reports));
  }
}
