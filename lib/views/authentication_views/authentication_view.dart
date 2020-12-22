import 'package:flutter/material.dart';

import 'package:fluttalor/views/authentication_views/login_view.dart';
import 'package:fluttalor/views/authentication_views/signup_view.dart';

class AuthenticationView extends StatelessWidget {
  static const String id = '/authentication_view';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        minimum: const EdgeInsets.symmetric(horizontal: 20),
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(),
              Column(
                children: <Widget>[
                  Image.asset(
                    'assets/images/logo_xl.png',
                    width: 250,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Text(
                      'Fluttalor',
                      style:
                          TextStyle(fontSize: 42, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  ElevatedButton(
                    onPressed: () =>
                        Navigator.pushNamed(context, SignupView.id),
                    child: const Text('Signup'),
                  ),
                  ElevatedButton(
                    onPressed: () => Navigator.pushNamed(context, LoginView.id),
                    child: const Text('Login'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
