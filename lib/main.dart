import 'package:flutter/material.dart';

import 'screens/home_screen.dart';

/// Entry point of the app.
void main() {
  runApp(const MyApp());
}

/// Root widget: sets the app title, theme and first screen.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Programming Languages Info Viewer',
      debugShowCheckedModeBanner: false, // hides the "DEBUG" ribbon
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.indigo, // main color of the app
      ),
      home: const HomeScreen(),
    );
  }
}
