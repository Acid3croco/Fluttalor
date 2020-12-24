import 'package:fluttalor/classes/label.dart';
import 'package:flutter/material.dart';

class LabelList with ChangeNotifier {
  List<Label> _labelList = <Label>[];

  Label getLabelFromIndex(int index) {
    if (index < _labelList.length)
      return _labelList[index];
    else
      return null;
  }

  int getLength() {
    return _labelList.length;
  }

  void setLabels(List<dynamic> labelData) {
    final List<Label> labelList = <Label>[];

    for (final dynamic label in labelData) {
      labelList.add(Label(
        label['pk'] as int,
        label['name'] as String,
      ));
    }

    _labelList = labelList;
    notifyListeners();
  }

  void addLabel(int pk, String name) {
    _labelList.add(Label(pk, name));
    notifyListeners();
  }

  void modifyLabel(Label label, String name) {
    label.modifyLabel(name);
    notifyListeners();
  }

  void deleteLabel(Label label) {
    _labelList.remove(label);
    notifyListeners();
  }
}
