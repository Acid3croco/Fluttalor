import 'package:fluttalor/views/authentication_views/login_view.dart';
import 'package:flutter/material.dart';

class SignupView extends StatelessWidget {
  static const String id = '/signup_view';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        minimum: const EdgeInsets.symmetric(horizontal: 20),
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const Center(
                child: Text(
                  "S'enregistrer",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Text("Nom d'utilisateur"),
              const TextField(),
              const Text('Mot de passe'),
              const TextField(),
              const TextField(),
              RaisedButton(
                onPressed: () => Navigator.pushNamed(context, LoginView.id),
                child: const Text("S'enregistrer"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
