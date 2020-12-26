import 'package:fluttalor/classes/contact.dart';
import 'package:flutter/material.dart';

class Profile with ChangeNotifier {
  Contact _profile;

  Contact getProfile() {
    if (_profile != null)
      return _profile;
    else
      return null;
  }

  void createProfile(int pk, String nickname, String firstname, String lastname,
      String phone, String email) {
    _profile = Contact(pk, nickname, firstname, lastname, phone, email, null);
    notifyListeners();
  }

  void modifyProfile(Map<String, String> newInfo) {
    _profile.modifyContact(newInfo);
    notifyListeners();
  }
}
