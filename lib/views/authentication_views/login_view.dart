import 'package:flutter/material.dart';

import 'package:fluttalor/views/contact_list/contact_list.dart';
import 'package:fluttalor/api/authentification.dart';

class LoginView extends StatefulWidget {
  static const String id = '/login_view';

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  bool _failLogin = false;

  void _submit() {
    if (_formKey.currentState.validate()) {
      AuthService.login(_email.text, _password.text).then((bool result) {
        if (result) {
          print('Submit success');
          _formKey.currentState.reset();
          Navigator.pushNamedAndRemoveUntil(
            context,
            ContactList.id,
            (Route<dynamic> route) => false,
          );
        } else {
          _failLogin = true;
          _formKey.currentState.validate();
          print('Submit fail');
        }
      });
    } else {
      print('Submit fail');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        minimum: const EdgeInsets.all(20),
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
              const SizedBox(height: 30),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    TextFormField(
                      controller: _email,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.mail_outline),
                        labelText: 'Addresse email',
                      ),
                      keyboardType: TextInputType.emailAddress,
                      validator: (String value) {
                        if (value.trim().isEmpty) {
                          return 'Email non valide.';
                        }
                        if (!value.contains('@')) {
                          return 'Email non valide, vous devez avoir un @.';
                        }
                        if (_failLogin) {
                          return 'Erreur lors de la connexion. Verifiez vos informations rentré.';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 30),
                    TextFormField(
                      controller: _password,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.lock_outlined),
                        labelText: 'Mot de passe',
                      ),
                      obscureText: true,
                      validator: (String value) {
                        if (value.trim().isEmpty) {
                          return 'Le mot de passe est vide.';
                        }
                        if (value.length < 5) {
                          return 'Votre mot de passe dois contenir au moins 5 caractères.';
                        }
                        if (_failLogin) {
                          _failLogin = false;
                          return 'Erreur lors de la connexion. Verifiez vos informations rentré.';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: _submit,
                      child: const Text('Se connecter'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
