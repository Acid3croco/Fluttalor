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

  void sortContactList() {
    final Contact profile = _contactList[0];
    _contactList.remove(profile);
    _contactList.sort((Contact a, Contact b) {
      int res;

      res = a.firstname.compareTo(b.firstname);
      if (res == 0) {
        res = a.lastname.compareTo(b.lastname);
      }
      if (res == 0) {
        res = a.nickname.compareTo(b.nickname);
      }
      return res;
    });
    _contactList.insert(0, profile);
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
          contact['labels'] as List<dynamic>,
          contact['profile'] as bool));
    }

    _contactList = contactList;
    notifyListeners();
  }

  void addContact(Contact newContact) {
    _contactList.add(newContact);
    sortContactList();
    notifyListeners();
  }

  void modifyContact() {
    sortContactList();
    notifyListeners();
  }

  void removeContact(Contact contact) {
    _contactList.remove(contact);
    sortContactList();
    notifyListeners();
  }
}
