import 'package:MusicIsLife/screen/welcome_screen.dart';
import 'package:flutter/material.dart';

class NAspace extends StatelessWidget {
  const NAspace({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black,
          surfaceTintColor: Colors.black,
          foregroundColor: Colors.white,
        ),
        useMaterial3: true,
      ),
      home: const WelcomeScreen(),
    );
  }
}
