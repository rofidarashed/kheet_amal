import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import '../cubit/bottom_nav_cubit.dart';
import '../widgets/bottom_nav_bar.dart';

class HomeLayoutPage extends StatelessWidget {
  HomeLayoutPage({super.key});

  final PersistentTabController _controller = PersistentTabController(
    initialIndex: 0,
  );

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => BottomNavCubit(),
      child: Scaffold(body: BottomNavBar(controller: _controller)),
    );
  }
}
