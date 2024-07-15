import 'package:flutter/material.dart';
import 'package:music_is_life/main/welcome_screen.dart';

class NAspace extends StatelessWidget {
  const NAspace({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.black,
        canvasColor: Colors.black,
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
