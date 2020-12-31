import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:provider/provider.dart';

import 'package:fluttalor/providers/labelListModel.dart';
import 'package:fluttalor/providers/contactListModel.dart';
import 'package:fluttalor/views/authentication/login.dart';
import 'package:fluttalor/views/authentication/signup.dart';
import 'package:fluttalor/views/contact_list/contact_list.dart';
import 'package:fluttalor/views/authentication/authentication.dart';
import 'package:fluttalor/views/contact_handler/contact_handler.dart';
import 'package:fluttalor/api/authentificationService.dart';
import 'package:fluttalor/utils/colors.dart';

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
        providers: <ChangeNotifierProvider<dynamic>>[
          // ChangeNotifierProvider(create: (_) => Profile()),
          ChangeNotifierProvider<ContactList>(create: (_) => ContactList()),
          ChangeNotifierProvider<LabelList>(create: (_) => LabelList()),
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
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
          ),
        ),
      ),
      home: _defaultHome,
      onGenerateRoute: (RouteSettings settings) {
        if (settings.name == ContactHandlerView.id) {
          final ContactHandlerArguments args =
              settings.arguments as ContactHandlerArguments;

          return MaterialPageRoute<ContactHandlerView>(
            builder: (BuildContext context) => ContactHandlerView(
              contact: args != null ? args.contact : null,
            ),
          );
        }
        return null;
      },
      routes: <String, WidgetBuilder>{
        ContactListView.id: (BuildContext context) => ContactListView(),
        LoginView.id: (BuildContext context) => LoginView(),
        SignupView.id: (BuildContext context) => SignupView(),
        AuthenticationView.id: (BuildContext context) => AuthenticationView(),
      },
    );
  }
}
