import 'package:fluttalor/providers/contactListModel.dart';
import 'package:fluttalor/providers/labelListModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:fluttalor/views/contact_list/contact_list.dart';
import 'package:fluttalor/views/contact_handler/contact_handler.dart';
import 'package:fluttalor/views/authentication/login.dart';
import 'package:fluttalor/views/authentication/signup.dart';
import 'package:fluttalor/views/authentication/authentication.dart';
import 'package:fluttalor/api/authentificationService.dart';
import 'package:fluttalor/utils/colors.dart';
import 'package:provider/provider.dart';

AuthService appAuth = AuthService();

Widget _defaultHome = AuthenticationView();

Future<bool> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final bool _result = await AuthService.checkToken();

  if (_result) {
    _defaultHome = ContactListView();
  }

  // Force orienation do portrait only
  SystemChrome.setPreferredOrientations(<DeviceOrientation>[
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]).then((_) {
    runApp(
      MultiProvider(
        providers: [
          // ChangeNotifierProvider(create: (_) => Profile()),
          ChangeNotifierProvider(create: (_) => ContactList()),
          ChangeNotifierProvider(create: (_) => LabelList()),
        ],
        child: MyApp(),
      ),
    );
  });
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
        ContactListView.id: (BuildContext context) => ContactListView(),
        ContactHandler.id: (BuildContext context) => ContactHandler(),
        LoginView.id: (BuildContext context) => LoginView(),
        SignupView.id: (BuildContext context) => SignupView(),
        AuthenticationView.id: (BuildContext context) => AuthenticationView(),
      },
    );
  }
}
