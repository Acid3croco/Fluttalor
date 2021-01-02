import 'package:fluttalor/api/authentificationService.dart';
import 'package:fluttalor/views/authentication/signup.dart';
import 'package:flutter/material.dart';

import 'package:fluttalor/views/contact_list/contact_list.dart';
import 'package:fluttalor/utils/custom_shadows.dart';

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
  bool _formValid = true;
  String _emailError = '';
  String _passwordError = '';

  bool _hidePassword = true;
  IconData _passwordIcon = Icons.visibility;

  void _submit() {
    _formKey.currentState.validate();
    if (_formValid) {
      AuthService.login(_email.text, _password.text).then((bool result) {
        if (result) {
          print('Submit success');
          _formKey.currentState.reset();
          Navigator.pushNamedAndRemoveUntil(
            context,
            ContactListView.id,
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
    setState(() {
      _formValid = true;
    });
  }

  void _togglePasswordVisibility() {
    setState(() {
      _hidePassword = !_hidePassword;
      _passwordIcon = _passwordIcon == Icons.visibility
          ? Icons.visibility_off
          : Icons.visibility;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          minimum: const EdgeInsets.all(20),
          child: Padding(
            padding: const EdgeInsets.only(top: 20),
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
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            child: TextFormField(
                              textAlign: TextAlign.left,
                              controller: _email,
                              decoration: const InputDecoration(
                                labelText: 'Addresse email',
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.never,
                                filled: true,
                                fillColor: Colors.white,
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 20, horizontal: 25),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(50),
                                  ),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                              keyboardType: TextInputType.emailAddress,
                              validator: (String value) {
                                if (value.trim().isEmpty) {
                                  setState(() {
                                    _formValid = false;
                                    _emailError = 'Email vide.';
                                  });
                                } else if (!value.contains('@')) {
                                  setState(() {
                                    _formValid = false;
                                    _emailError = 'Email non valide.';
                                  });
                                } else {
                                  setState(() {
                                    _formValid = _formValid && true;
                                    _emailError = '';
                                  });
                                }
                                return null;
                              },
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              boxShadow: customShadow[1],
                            ),
                          ),
                          if (_emailError.isNotEmpty)
                            ErrorTextField(error: _emailError)
                          else
                            Container()
                        ],
                      ),
                      const SizedBox(height: 30),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            child: TextFormField(
                              controller: _password,
                              decoration: InputDecoration(
                                suffixIcon: Padding(
                                  padding: const EdgeInsets.only(right: 20),
                                  child: GestureDetector(
                                    onTap: () => _togglePasswordVisibility(),
                                    child: Icon(_passwordIcon),
                                  ),
                                ),
                                labelText: 'Mot de passe',
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.never,
                                filled: true,
                                fillColor: Colors.white,
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 20, horizontal: 25),
                                border: const OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(50),
                                  ),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                              obscureText: _hidePassword,
                              validator: (String value) {
                                if (value.trim().isEmpty) {
                                  setState(() {
                                    _formValid = false;
                                    _passwordError =
                                        'Le mot de passe est vide.';
                                  });
                                } else if (value.length < 5) {
                                  setState(() {
                                    _formValid = false;
                                    _passwordError =
                                        'Votre mot de passe dois contenir au moins 5 caractères.';
                                  });
                                } else if (_failLogin) {
                                  setState(() {
                                    _failLogin = false;
                                    _passwordError =
                                        'Erreur lors de la connexion. Verifiez vos informations rentré.';
                                  });
                                } else {
                                  setState(() {
                                    _formValid = _formValid && true;
                                    _passwordError = '';
                                  });
                                }
                                return null;
                              },
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              boxShadow: customShadow[1],
                            ),
                          ),
                          if (_passwordError.isNotEmpty)
                            ErrorTextField(error: _passwordError)
                          else
                            Container()
                        ],
                      ),
                      const SizedBox(height: 30),
                      Container(
                        child: ElevatedButton(
                          onPressed: _submit,
                          child: const Text('Se connecter'),
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          boxShadow: customShadow[1],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
