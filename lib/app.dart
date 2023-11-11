import 'package:flutter/material.dart';
import 'package:task_manager_app/ui/screens/splash_screen.dart';

class TaskManager_App extends StatelessWidget {
  const TaskManager_App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
      theme: ThemeData(
          inputDecorationTheme: const InputDecorationTheme(
            fillColor: Colors.white,
            filled: true,
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
            ),
          ),
          textTheme: const TextTheme(
            titleLarge: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w600,
            ),
          ),
          primaryColor: Colors.green,
          primarySwatch: Colors.green,
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 10),
              //maximumSize: const Size.fromWidth(double.infinity),
            ),
          )),
    );
  }
}
