import 'package:flutter/material.dart';

// import 'package:provider/provider.dart';

import 'package:fluttalor/views/contact_list/contact_list.dart';
import 'package:fluttalor/views/contact_handler/contact_handler.dart';
import 'package:fluttalor/views/authentication_views/login_view.dart';
import 'package:fluttalor/views/authentication_views/signup_view.dart';
import 'package:fluttalor/views/authentication_views/authentication_view.dart';

void main() {
  runApp(MyApp());
  //   MultiProvider(
  //     providers: [],
  //     child: MyApp(),
  //   ),
  // );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: true == false ? ContactList.id : AuthenticationView.id,
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
