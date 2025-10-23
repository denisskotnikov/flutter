import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/product_cubit.dart';
import 'screens/navigation_screen.dart';
import 'data/database.dart';

class AppNavigation extends StatelessWidget {
  const AppNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductCubit(
        database: context.read<DataBasePrefs>(),
      )..loadProducts(),
      child: const NavigationScreen(),
    );
  }
}