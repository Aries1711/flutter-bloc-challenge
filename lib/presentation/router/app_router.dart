import 'package:bloc_challenge/business_logic/cubit/counter_cubit.dart';
import 'package:bloc_challenge/presentation/screens/home_screen.dart';
import 'package:bloc_challenge/presentation/screens/home_second_screen.dart';
import 'package:bloc_challenge/presentation/screens/home_three_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRouter {
  final CounterCubit _counterCubit = CounterCubit();

  Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => HomeScreen(
            title: "Home Screen",
          ),
        );
      case '/second':
        return MaterialPageRoute(
          builder: (_) => HomeSecondScreen(
            title: "Home Screen kedua",
          ),
        );
      case '/three':
        return MaterialPageRoute(
          builder: (_) => HomeThreeScreen(
            title: "Home Screen ketiga",
          ),
        );
      default:
        return null;
    }
  }

  void dispose() {
    _counterCubit.close();
  }
}
