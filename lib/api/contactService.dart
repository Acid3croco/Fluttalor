import 'dart:async';
import 'dart:convert';

// import 'dart:convert';
import 'package:fluttalor/.env.dart';
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
  static Future<bool> createContact() async {
    const String uri = '$apiUrl/contact/';
    final String accessToken = await _storage.read(key: 'access');

    final http.Response response = await http.post(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken'
      },
    );

    // print(response.body);
    if (response.statusCode == 200) {
      return true;
    }

    return false;
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
