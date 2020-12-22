import 'package:fluttalor/views/authentication_views/authentification.dart';
import 'package:flutter/material.dart';

import 'package:fluttalor/views/contact_list/contact_list.dart';
import 'package:fluttalor/views/contact_handler/contact_handler.dart';
import 'package:fluttalor/views/authentication_views/login_view.dart';
import 'package:fluttalor/views/authentication_views/signup_view.dart';
import 'package:fluttalor/views/authentication_views/authentication_view.dart';

import 'class/colors.dart';

AuthService appAuth = AuthService();

Widget _defaultHome = AuthenticationView();

Future<bool> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final bool _result = await AuthService.checkToken();

  if (_result) {
    _defaultHome = ContactList();
  }

  runApp(MyApp());
  //   MultiProvider(
  //     providers: [
  //     ],
  //     child: MyApp(),
  //   ),
  // );
  return true;
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fluttalor',
      theme: ThemeData(
        primarySwatch: myBlue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: _defaultHome,
      routes: <String, WidgetBuilder>{
        ContactList.id: (BuildContext context) => ContactList(),
        ContactHandler.id: (BuildContext context) => ContactHandler(),
        LoginView.id: (BuildContext context) => LoginView(),
        SignupView.id: (BuildContext context) => SignupView(),
        AuthenticationView.id: (BuildContext context) => AuthenticationView(),
      },
    );
  }
}
