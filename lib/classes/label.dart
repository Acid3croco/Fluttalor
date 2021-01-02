import 'package:flutter/material.dart';

import 'package:fluttalor/utils/colors.dart';

class Label {
  Label(int pk, String name) {
    _pk = pk;
    _name = name;
  }

  int _pk;
  String _name;

  int get pk => _pk;
  String get name => _name;

  void modifyLabel(String name) {
    _name = name;
  }

  MaterialColor getLabelColor() {
    final int index = _pk % 4;

    switch (index) {
      case 1:
        return myRed;
      case 2:
        return myYellow;
      case 3:
        return myGreen;
      case 4:
        return myBlue;
      default:
        return myGreyDark;
    }
  }
}
