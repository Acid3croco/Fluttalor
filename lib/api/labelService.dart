import 'dart:async';
import 'dart:convert';

// import 'dart:convert';
import 'package:fluttalor/.env.dart';
import 'package:http/http.dart' as http;

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LabelService {
  static const FlutterSecureStorage _storage = FlutterSecureStorage();

  // Retrieve all label.
  static Future<List<dynamic>> getLabels() async {
    const String uri = '$apiUrl/label/';
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
      final List<dynamic> labelList =
          json.decode(response.body) as List<dynamic>;
      return labelList;
    }

    return null;
  }

  // Retrieve label from primary key.
  static Future<bool> getLabel(String pk) async {
    final String uri = '$apiUrl/label/$pk';
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
      return true;
    }

    return false;
  }

  // Create label.
  static Future<bool> createLabel() async {
    const String uri = '$apiUrl/label/';
    final String accessToken = await _storage.read(key: 'access');

    final http.Response response = await http.post(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken'
      },
    );

    print(response.body);
    if (response.statusCode == 200) {
      return true;
    }

    return false;
  }

  // Modify label from primary key.
  static Future<bool> modifyLabel(String pk) async {
    final String uri = '$apiUrl/label/$pk';
    final String accessToken = await _storage.read(key: 'access');

    final http.Response response = await http.put(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken'
      },
    );

    print(response.body);
    if (response.statusCode == 200) {
      return true;
    }

    return false;
  }

  // Remove label from primary key.
  static Future<bool> removeLabel(String pk) async {
    final String uri = '$apiUrl/label/$pk';
    final String accessToken = await _storage.read(key: 'access');

    final http.Response response = await http.delete(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken'
      },
    );

    print(response.body);
    if (response.statusCode == 200) {
      return true;
    }

    return false;
  }
}
