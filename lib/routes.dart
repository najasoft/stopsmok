// app_routes.dart
import 'package:flutter/material.dart';
import 'package:stopsmok/screens/home_screen.dart';
import 'package:stopsmok/screens/settings_screen.dart';

class AppRoutes {
  static final Map<String, WidgetBuilder> routes = {
    '/': (context) => HomeScreen(),
    '/settings': (context) => SettingsScreen(),
  };
}
