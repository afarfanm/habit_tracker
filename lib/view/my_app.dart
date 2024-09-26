import 'package:flutter/material.dart';
import 'package:habit_tracker/view/home_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Habit Tracker',
      theme: ThemeData(
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
            backgroundColor: Colors.green, foregroundColor: Colors.white),
        appBarTheme: const AppBarTheme(
            color: Colors.green, foregroundColor: Colors.white),
      ),
      home: const HomePage(title: 'Home'),
    );
  }
}
