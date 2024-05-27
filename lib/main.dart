import 'dart:io';

import 'package:MusicIsLife/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'main/naspace.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  debugPrint('Current directory: ${Directory.current.path}');

  await dotenv.load(fileName: ".env");

  if (File('.env').existsSync()) {
    debugPrint('.env file found');
  } else {
    debugPrint('.env file not found');
  }
  runApp(
    const NAspace(),
  );
}
