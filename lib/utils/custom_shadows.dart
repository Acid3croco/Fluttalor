import 'dart:ui' show Color, Offset;

import 'package:flutter/painting.dart';

const Map<int, List<BoxShadow>> customShadow = _elevationToShadow;

const Color _kKeyPenumbraOpacity = Color(0x20000000); // alpha = 0.14
const Color _kAmbientShadowOpacity = Color(0x10000000); // alpha = 0.12
const Map<int, List<BoxShadow>> _elevationToShadow = <int, List<BoxShadow>>{
  // The empty list depicts no elevation.
  0: <BoxShadow>[],

  1: <BoxShadow>[
    BoxShadow(
        offset: Offset(0.0, 9.0),
        blurRadius: 12.0,
        spreadRadius: 1.0,
        color: _kKeyPenumbraOpacity),
    BoxShadow(
        offset: Offset(0.0, 3.0),
        blurRadius: 16.0,
        spreadRadius: 2.0,
        color: _kAmbientShadowOpacity),
  ],
};
