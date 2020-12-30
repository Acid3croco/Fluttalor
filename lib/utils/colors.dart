import 'dart:ui';

import 'package:flutter/material.dart';

MaterialColor createMaterialColor(Color color) {
  final List<double> strengths = <double>[.05];
  final Map<int, Color> swatch = <int, Color>{};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  for (final double strength in strengths) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  }
  return MaterialColor(color.value, swatch);
}

MaterialColor myBlue = createMaterialColor(const Color(0xFF2F80ED));
MaterialColor myRed = createMaterialColor(const Color(0xFFEF476F));
MaterialColor myYellow = createMaterialColor(const Color(0xFFFFD166));
MaterialColor myGreen = createMaterialColor(const Color(0xFF06D6A0));
MaterialColor myGreyLight = createMaterialColor(const Color(0xFFE9EBF8));
MaterialColor myGreyDark = createMaterialColor(const Color(0xFF212227));
MaterialColor myDark = createMaterialColor(const Color(0xFF090C08));
