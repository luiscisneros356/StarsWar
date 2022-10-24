import 'package:flutter/material.dart';
import 'package:personajes_star_war/screens/details.dart';
import 'package:personajes_star_war/screens/home.dart';
import 'package:personajes_star_war/screens/reported_list.dart';
import 'package:personajes_star_war/screens/splash.dart';

class RoutesApp {
  static const String home = "/home";
  static const String details = "/details";
  static const String reportedList = "/reportedList";
  static const String splash = "/splash";

  static Map<String, Widget Function(BuildContext)> getRoutes() {
    return {
      RoutesApp.home: (context) => HomeScreen(),
      RoutesApp.details: (context) => const DetailsScreen(),
      RoutesApp.reportedList: (context) => ReportedList(),
      RoutesApp.splash: (context) => const Splash()
    };
  }
}
