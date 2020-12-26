import 'package:fluttalor/classes/contact.dart';
import 'package:fluttalor/classes/label.dart';
import 'package:flutter/material.dart';

class ContactList with ChangeNotifier {
  List<Contact> _contactList = <Contact>[];

  Contact getContactFromIndex(int index) {
    if (index < _contactList.length)
      return _contactList[index];
    else
      return null;
  }

  int getLength() {
    return _contactList.length;
  }

  void setContacts(List<dynamic> contactData) {
    final List<Contact> contactList = <Contact>[];

    for (final dynamic contact in contactData) {
      final List<Label> labelList = <Label>[];

      for (final dynamic label in contact['labels']) {
        labelList.add(Label(
          label['pk'] as int,
          label['name'] as String,
        ));
      }

      contactList.add(Contact(
          contact['pk'] as int,
          contact['nickname'] as String,
          contact['firstname'] as String,
          contact['lastname'] as String,
          contact['phone'] as String,
          contact['email'] as String,
          labelList));
    }
    print(contactList);

    _contactList = contactList;
    notifyListeners();
  }

  void addContact(int pk, String nickname, String firstname, String lastname,
      String phone, String email, List<Label> labels) {
    _contactList
        .add(Contact(pk, nickname, firstname, lastname, phone, email, labels));
    notifyListeners();
  }

  void modifyContact(Contact contact, Map<String, String> newInfo) {
    contact.modifyContact(newInfo);
    notifyListeners();
  }

  void deleteContact(Contact contact) {
    _contactList.remove(contact);
    notifyListeners();
  }
}
