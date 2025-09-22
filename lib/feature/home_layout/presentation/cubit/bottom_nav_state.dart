abstract class BottomNavState {
  final int index;

  BottomNavState({required this.index});
}

final class BottomNavInitial extends BottomNavState {

  BottomNavInitial({required super.index});
}

final class BottomNavChange extends BottomNavState {
  @override
  final int index;
  BottomNavChange({required this.index}) : super(index: 0);
}
