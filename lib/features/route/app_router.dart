import 'package:flutter/material.dart';
import 'package:klontong_project/features/route/app_arguments.dart';
import 'package:klontong_project/features/route/routes.dart';
import 'package:klontong_project/features/screens/input_screen/input_screen.dart';
import 'package:klontong_project/features/screens/main_screen/main_screen.dart';

class AppRouter {
  Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.mainRoute:
        return MaterialPageRoute(builder: (_) => const MainScreen());
      case Routes.inputRoute:
        var arguments = settings.arguments as InputArguments;
        return MaterialPageRoute(
            builder: (_) => InputScreen(arguments: arguments));
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
