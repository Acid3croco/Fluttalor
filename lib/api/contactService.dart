import 'dart:async';
import 'dart:convert';

// import 'dart:convert';
import 'package:fluttalor/.env.dart';
import 'package:fluttalor/api/authentificationService.dart';
import 'package:fluttalor/classes/contact.dart';
import 'package:http/http.dart' as http;

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ContactService {
  static const FlutterSecureStorage _storage = FlutterSecureStorage();

  // Retrieve all contact.
  static Future<List<dynamic>> getContacts() async {
    const String uri = '$apiUrl/contact/';
    final String accessToken = await _storage.read(key: 'access');

    final http.Response response = await http.get(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken'
      },
    );

    // print(response.body);
    if (response.statusCode == 200) {
      final List<dynamic> contactList =
          json.decode(response.body) as List<dynamic>;
      return contactList;
    } else if (response.statusCode == 401) {
      AuthService.refreshToken();
    }

    return null;
  }

  // Retrieve contact from primary key.
  static Future<bool> getContact(String pk) async {
    final String uri = '$apiUrl/contact/$pk/';
    final String accessToken = await _storage.read(key: 'access');

    final http.Response response = await http.get(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken'
      },
    );

    //print(response.body);
    if (response.statusCode == 200) {
      return true;
    } else if (response.statusCode == 401) {
      AuthService.refreshToken();
    }

    return false;
  }

  // Create contact.
  static Future<Contact> createContact(
      String _nickname,
      String _firstname,
      String _lastname,
      String _phone,
      String _email,
      String _address,
      List<dynamic> _labels) async {
    const String uri = '$apiUrl/contact/';
    final String accessToken = await _storage.read(key: 'access');

    _labels ??= <dynamic>[];

    final dynamic requestBody = <String, dynamic>{
      'nickname': _nickname,
      'firstname': _firstname,
      'lastname': _lastname,
      'phone': _phone,
      'email': _email,
      'address': _address,
      'labels_id': _labels
    };

    final http.Response response = await http.post(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken'
      },
      body: json.encode(requestBody),
    );

    // print(response.body);
    if (response.statusCode == 201) {
      final dynamic contact = json.decode(response.body);

      final Contact newContact = Contact(
          contact['pk'] as int,
          contact['nickname'] as String,
          contact['firstname'] as String,
          contact['lastname'] as String,
          contact['phone'] as String,
          contact['email'] as String,
          contact['address'] as String,
          contact['icon'] as String,
          contact['labels'] as List<dynamic>,
          contact['profile'] as bool);
      return newContact;
    } else if (response.statusCode == 401) {
      AuthService.refreshToken();
    }

    return null;
  }

  // Modify contact from primary key.
  static Future<Contact> modifyContact(
      Contact contact,
      String _nickname,
      String _firstname,
      String _lastname,
      String _phone,
      String _email,
      String _address,
      List<dynamic> _labels) async {
    final int pk = contact.pk;
    final String uri = '$apiUrl/contact/$pk/';
    final String accessToken = await _storage.read(key: 'access');

    _labels ??= <dynamic>[];

    final dynamic requestBody = <String, dynamic>{
      'nickname': _nickname,
      'firstname': _firstname,
      'lastname': _lastname,
      'phone': _phone,
      'email': _email,
      'address': _address,
      'labels_id': _labels
    };

    print(json.encode(requestBody));
    final http.Response response = await http.put(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken'
      },
      body: json.encode(requestBody),
    );

    // print(response.body);
    if (response.statusCode == 200) {
      final dynamic contactRet = json.decode(response.body);

      contact.modifyContact(<String, String>{
        'nickname': contactRet['nickname'] as String,
        'firstname': contactRet['firstname'] as String,
        'lastname': contactRet['lastname'] as String,
        'phone': contactRet['phone'] as String,
        'email': contactRet['email'] as String,
        'address': contactRet['address'] as String,
        'icon': contactRet['icon'] as String,
      });
      contact.setLabel(contactRet['labels'] as List<dynamic>);

      return contact;
    } else if (response.statusCode == 401) {
      AuthService.refreshToken();
    }

    return null;
  }

  // Remove contact from primary key.
  static Future<bool> removeContact(int pk) async {
    final String uri = '$apiUrl/contact/$pk/';
    final String accessToken = await _storage.read(key: 'access');

    final http.Response response = await http.delete(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken'
      },
    );

    // print(response.body);
    if (response.statusCode == 200) {
      return true;
    } else if (response.statusCode == 401) {
      AuthService.refreshToken();
    }

    return false;
  }
}
