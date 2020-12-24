import 'package:flutter/material.dart';

import 'package:fluttalor/views/authentication/login.dart';
import 'package:fluttalor/views/authentication/signup.dart';
import 'package:fluttalor/utils/custom_shadows.dart';
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
                  Container(
                    child: ElevatedButton(
                      onPressed: () =>
                          Navigator.pushNamed(context, SignupView.id),
                      child: const Text('Créer un compte'),
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      boxShadow: customShadow[1],
                    ),
                  ),
                  const SizedBox(height: 30),
                  Container(
                    child: ElevatedButton(
                      onPressed: () =>
                          Navigator.pushNamed(context, LoginView.id),
                      child: const Text('Se connecter'),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        onPrimary: myDark,
                      ),
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      boxShadow: customShadow[1],
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
