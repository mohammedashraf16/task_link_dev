import 'package:flutter/material.dart';
import 'package:task_link_dev/config/router_transitions.dart';
import 'package:task_link_dev/config/routes.dart';
import 'package:task_link_dev/features/home/presentation/views/home_view.dart';

class AppRouter {
  Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.home:
        return RouterTransitions.buildHorizontal(HomeView());
      default:
        return RouterTransitions.build(
          Scaffold(body: Center(child: Text("No Route"))),
        );
    }
  }
}
