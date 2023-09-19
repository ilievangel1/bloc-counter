import 'package:flutter/material.dart';
import 'package:flutter_bloc_counter_app/presentation/screens/home_screen.dart';
import 'package:flutter_bloc_counter_app/presentation/screens/second_screen.dart';
import 'package:flutter_bloc_counter_app/presentation/screens/third_screen.dart';

class AppRouter {
  Route onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (context) => const HomeScreen(
            title: 'Flutter Demo Home Page',
            color: Colors.yellow,
          ),
        );
      case '/second':
        return MaterialPageRoute(
          builder: (context) =>
              const SecondScreen(title: 'Second screen', color: Colors.lime),
        );
      case '/third':
        return MaterialPageRoute(
          builder: (context) =>
              const ThirdScreen(title: 'Third screen', color: Colors.pink),
        );
      default:
        return MaterialPageRoute(
          builder: (context) => const HomeScreen(
            title: 'Flutter Demo Home Page',
            color: Colors.yellow,
          ),
        );
    }
  }
}
