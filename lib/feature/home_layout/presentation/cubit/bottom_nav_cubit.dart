import 'package:bloc/bloc.dart';

import 'bottom_nav_state.dart';

class BottomNavCubit extends Cubit<BottomNavState> {
  BottomNavCubit() : super(BottomNavInitial(index: 0));
  void changeIndex(int index) {
    emit(BottomNavChange(index: index));
  }
}
