import 'package:flutter/material.dart';

import 'package:fluttalor/views/authentication_views/login_view.dart';
import 'package:fluttalor/views/authentication_views/signup_view.dart';
import 'package:fluttalor/utils/colors.dart';

class AuthenticationView extends StatelessWidget {
  static const String id = '/authentication_view';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        minimum: const EdgeInsets.all(20),
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(),
              Column(
                children: <Widget>[
                  const Text(
                    'Gerez vos contacts en un seul endroit',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20, right: 16),
                    child: Image.asset(
                      'assets/images/contact_image.png',
                      width: 250,
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
                    child: const Text('Créer un compte'),
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () => Navigator.pushNamed(context, LoginView.id),
                    child: const Text('Se connecter'),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      onPrimary: myDark,
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
