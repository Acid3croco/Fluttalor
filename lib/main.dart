import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:fluttalor/views/contact_list/contact_list.dart';
import 'package:fluttalor/views/contact_handler/contact_handler.dart';
import 'package:fluttalor/views/authentication_views/login_view.dart';
import 'package:fluttalor/views/authentication_views/signup_view.dart';
import 'package:fluttalor/views/authentication_views/authentication_view.dart';
import 'package:fluttalor/api/authentification.dart';
import 'package:fluttalor/utils/colors.dart';

AuthService appAuth = AuthService();

Widget _defaultHome = AuthenticationView();

Future<bool> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final bool _result = await AuthService.checkToken();

  if (_result) {
    _defaultHome = ContactList();
  }

  // Force orienation do portrait only
  SystemChrome.setPreferredOrientations(<DeviceOrientation>[
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]).then((_) {
    runApp(MyApp());
  });
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
        fontFamily: 'RedHatText',
        primarySwatch: myBlue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            elevation: 0,
            textStyle: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
            padding: const EdgeInsets.all(15),
          ),
        ),
        inputDecorationTheme: const InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          floatingLabelBehavior: FloatingLabelBehavior.never,
          contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 25),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(50),
            ),
            borderSide: BorderSide.none,
          ),
        ),
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
