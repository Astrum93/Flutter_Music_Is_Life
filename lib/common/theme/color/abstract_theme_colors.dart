import 'package:flutter/material.dart';

typedef ColorProvider = Color Function();

abstract class AbstractThemeColors {
  const AbstractThemeColors();

  Color get divider => const Color.fromARGB(255, 228, 228, 228);
}
