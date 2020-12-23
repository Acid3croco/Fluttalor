import 'package:flutter/material.dart';

import 'package:fluttalor/views/authentication_views/login_view.dart';
import 'package:fluttalor/api/authentification.dart';

class SignupView extends StatefulWidget {
  static const String id = '/signup_view';

  @override
  _SignupViewState createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _passwordVerify = TextEditingController();

  bool _failMail = false;

  void _submit() {
    if (_formKey.currentState.validate() &&
        _password.text == _passwordVerify.text) {
      print('Submit success');
      AuthService.register(_email.text, _password.text).then((bool result) {
        if (result) {
          _formKey.currentState.reset();
          Navigator.pushNamed(
            context,
            LoginView.id,
          );
        } else {
          _failMail = true;
          _formKey.currentState.validate();
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
                  'Créer un compte',
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
                    Container(
                      child: TextFormField(
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
                          if (_failMail) {
                            _failMail = false;
                            return 'Cette email est déjà utilisé.';
                          }
                          return null;
                        },
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        boxShadow: kElevationToShadow[12],
                      ),
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
                          return 'le mot de passe est vide.';
                        }
                        if (value.length < 5) {
                          return 'Votre mot de passe dois contenir au moins 5 caractères.';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 30),
                    TextFormField(
                      controller: _passwordVerify,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.lock_outlined),
                        labelText: 'Vérification du mot de passe',
                      ),
                      obscureText: true,
                      validator: (String value) {
                        if (value.trim().isEmpty) {
                          return 'le mot de passe est vide.';
                        }
                        if (value.length < 5) {
                          return 'Votre mot de passe dois contenir au moins 5 caractères.';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    ElevatedButton(
                      onPressed: _submit,
                      child: const Text('Créer un compte'),
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
