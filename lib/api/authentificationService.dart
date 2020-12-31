import 'dart:async';

import 'dart:convert';
import 'package:fluttalor/.env.dart';
import 'package:http/http.dart' as http;

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService {
  static const FlutterSecureStorage _storage = FlutterSecureStorage();

  // Login
  static Future<bool> login(String email, String password) async {
    const String uri = '$apiUrl/account/login/';

    final dynamic requestBody = <String, String>{
      'username': email,
      'password': password
    };

    final http.Response response = await http.post(
      uri,
      headers: <String, String>{'Content-Type': 'application/json'},
      body: json.encode(requestBody),
    );

    if (response.statusCode == 200) {
      final dynamic tokens = json.decode(response.body);

      await _storage.write(key: 'access', value: tokens['access'] as String);
      await _storage.write(key: 'refresh', value: tokens['refresh'] as String);
      return true;
    }

    return false;
  }

  //Check token
  static Future<bool> checkToken() async {
    const String uri = '$apiUrl/token/verify/';
    final String access = await _storage.read(key: 'access');

    final dynamic requestBody = <String, String>{'token': access};

    final http.Response response = await http.post(
      uri,
      headers: <String, String>{'Content-Type': 'application/json'},
      body: json.encode(requestBody),
    );

    if (response.statusCode == 200) {
      return true;
    }

    return false;
  }

  //Refresh token
  static Future<bool> refreshToken() async {
    const String uri = '$apiUrl/token/refresh/';
    final String refresh = await _storage.read(key: 'refresh');

    final dynamic requestBody = <String, String>{'refresh': refresh};

    final http.Response response = await http.post(
      uri,
      headers: <String, String>{'Content-Type': 'application/json'},
      body: json.encode(requestBody),
    );

    if (response.statusCode == 200) {
      final dynamic tokens = json.decode(response.body);

      await _storage.write(key: 'access', value: tokens['access'] as String);
      return true;
    }

    return false;
  }

  //Register
  static Future<bool> register(String email, String password) async {
    const String uri = '$apiUrl/user/';
    final dynamic requestBody = <String, String>{
      'username': email,
      'email': email,
      'password': password
    };

    final http.Response response = await http.post(
      uri,
      headers: <String, String>{'Content-Type': 'application/json'},
      body: json.encode(requestBody),
    );

    if (response.statusCode == 201) {
      return true;
    }

    return false;
  }

  // Logout
  static Future<void> logout() async {
    return await _storage.deleteAll();
  }
}
