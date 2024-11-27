
import 'package:blood_donation_app_flutter/view/splash/splash.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Hide the debug banner
      theme: ThemeData(
        primaryColor: Colors.red[100], // Set light red as the main color
        fontFamily: 'Poppins', // Use Poppins font as the main text style
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Colors.black, fontFamily: 'Poppins'),
        ),
        appBarTheme: AppBarTheme(// Set light red for AppBar background
          titleTextStyle: const TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      home: const SplashScreen(),
    );
  }
}
