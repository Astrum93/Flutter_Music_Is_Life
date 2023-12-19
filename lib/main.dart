import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:naspace/Screen/welcome.dart';
import 'package:naspace/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const NAspace());
}

class NAspace extends StatelessWidget {
  const NAspace({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WelcomeScreen(),
    );
  }
}
