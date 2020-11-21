import 'package:fluttalor/views/authentication_views/login_view.dart';
import 'package:flutter/material.dart';

class SignupView extends StatelessWidget {
  static const String id = '/signup_view';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: <Widget>[
          RaisedButton(
            onPressed: () => Navigator.pushNamed(context, LoginView.id),
            child: const Text('Login'),
          ),
        ],
      ),
    );
  }
}
