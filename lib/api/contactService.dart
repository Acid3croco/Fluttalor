import 'dart:async';
import 'dart:convert';

// import 'dart:convert';
import 'package:fluttalor/.env.dart';
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

    print(response.body);
    if (response.statusCode == 200) {
      final List<dynamic> contactList =
          json.decode(response.body) as List<dynamic>;
      return contactList;
    }

    return null;
  }

  // Retrieve contact from primary key.
  static Future<bool> getContact(String pk) async {
    final String uri = '$apiUrl/contact/$pk';
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
    }

    return false;
  }

  // Create contact.
  static Future<Contact> createContact(String _nickname, String _firstname,
      String _lastname, String _phone, String _email) async {
    const String uri = '$apiUrl/contact/';
    final String accessToken = await _storage.read(key: 'access');

    final dynamic requestBody = <String, String>{
      'nickname': _nickname,
      'firsname': _firstname,
      'lastname': _lastname,
      'phone': _phone,
      'email': _email
    };

    final http.Response response = await http.post(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken'
      },
      body: json.encode(requestBody),
    );

    print(response.body);
    if (response.statusCode == 200) {
      final dynamic contact = response.body;

      final Contact newContact = Contact(
          contact['pk'] as int,
          contact['nickname'] as String,
          contact['firstname'] as String,
          contact['lastname'] as String,
          contact['phone'] as String,
          contact['email'] as String,
          contact['icon'] as String,
          contact['labels'] as List<dynamic>);
      return newContact;
    }

    return null;
  }

  // Modify contact from primary key.
  static Future<bool> modifyContact(String pk) async {
    final String uri = '$apiUrl/contact/$pk';
    final String accessToken = await _storage.read(key: 'access');

    final http.Response response = await http.put(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken'
      },
    );

    //print(response.body);
    if (response.statusCode == 200) {
      return true;
    }

    return false;
  }

  // Remove contact from primary key.
  static Future<bool> removeContact(String pk) async {
    final String uri = '$apiUrl/contact/$pk';
    final String accessToken = await _storage.read(key: 'access');

    final http.Response response = await http.delete(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken'
      },
    );

    //print(response.body);
    if (response.statusCode == 200) {
      return true;
    }

    return false;
  }
}
