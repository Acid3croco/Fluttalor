import 'package:fluttalor/utils/colors.dart';
import 'package:fluttalor/utils/custom_shadows.dart';
import 'package:flutter/material.dart';

import 'package:fluttalor/views/authentication/login.dart';
import 'package:fluttalor/api/authentificationService.dart';

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
  bool _formValid = true;
  String _emailError = '';
  String _passwordError = '';
  String _passwordVerifyError = '';

  bool _hidePassword = true;
  IconData _passwordIcon = Icons.visibility;
  bool _hidePasswordVerify = true;
  IconData _passwordVerifyIcon = Icons.visibility;

  void _submit() {
    _formKey.currentState.validate();
    if (_formValid && _password.text == _passwordVerify.text) {
      AuthService.register(_email.text, _password.text).then((bool result) {
        if (result) {
          print('Submit success');
          _formKey.currentState.reset();
          Navigator.pushNamed(
            context,
            LoginView.id,
          );
        } else {
          _failMail = true;
          _formKey.currentState.validate();
          print('Submit fail');
        }
      });
    } else {
      print('Submit fail, form wrong');
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

  void _togglePasswordVerifyVisibility() {
    setState(() {
      _hidePasswordVerify = !_hidePasswordVerify;
      _passwordVerifyIcon = _passwordVerifyIcon == Icons.visibility
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
                                } else if (_failMail) {
                                  setState(() {
                                    _failMail = false;
                                    _emailError =
                                        'Cette email est déjà utilisé.';
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
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            child: TextFormField(
                              controller: _passwordVerify,
                              decoration: InputDecoration(
                                suffixIcon: Padding(
                                  padding: const EdgeInsets.only(right: 20),
                                  child: GestureDetector(
                                    onTap: () =>
                                        _togglePasswordVerifyVisibility(),
                                    child: Icon(_passwordVerifyIcon),
                                  ),
                                ),
                                labelText: 'Vérification du mot de passe',
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
                              obscureText: _hidePasswordVerify,
                              validator: (String value) {
                                if (_password.text != _passwordVerify.text) {
                                  setState(() {
                                    _formValid = false;
                                    _passwordVerifyError =
                                        'Les mots de passe ne concordent pas';
                                  });
                                } else {
                                  setState(() {
                                    _formValid = _formValid && true;
                                    _passwordVerifyError = '';
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
                          if (_passwordVerifyError.isNotEmpty)
                            ErrorTextField(error: _passwordVerifyError)
                          else
                            Container()
                        ],
                      ),
                      const SizedBox(height: 30),
                      Container(
                        child: ElevatedButton(
                          onPressed: _submit,
                          child: const Text('Créer un compte'),
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

class ErrorTextField extends StatelessWidget {
  const ErrorTextField({
    Key key,
    @required String error,
  })  : _error = error,
        super(key: key);

  final String _error;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25, right: 25, top: 10),
      child: Text(
        _error,
        style: TextStyle(
          fontSize: 12,
          color: myRed,
        ),
      ),
    );
  }
}
