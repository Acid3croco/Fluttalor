import 'package:fluttalor/classes/contact.dart';
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
      contactList.add(Contact(
          contact['pk'] as int,
          contact['nickname'] as String,
          contact['firstname'] as String,
          contact['lastname'] as String,
          contact['phone'] as String,
          contact['email'] as String,
          contact['address'] as String,
          contact['icon'] as String,
          contact['labels'] as List<dynamic>));
    }

    _contactList = contactList;
    notifyListeners();
  }

  void addContact(Contact newContact) {
    _contactList.add(newContact);
    notifyListeners();
  }

  void modifyContact() {
    notifyListeners();
  }

  void removeContact(Contact contact) {
    _contactList.remove(contact);
    notifyListeners();
  }
}
