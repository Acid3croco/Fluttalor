import 'package:flutter/material.dart';

import 'package:fluttalor/views/contact_list/contact_list.dart';

class LoginView extends StatelessWidget {
  static const String id = '/login_view';

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
                  'Se connecter',
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
              RaisedButton(
                onPressed: () => Navigator.pushNamedAndRemoveUntil(
                  context,
                  ContactList.id,
                  (Route<dynamic> route) => false,
                ),
                child: const Text('Se connecter'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
