import 'package:flutter/material.dart';

import 'package:fluttalor/views/authentication_views/login_view.dart';
import 'package:fluttalor/views/authentication_views/signup_view.dart';

class AuthenticationView extends StatelessWidget {
  static const String id = '/authentication_view';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        child: Column(
          children: <Widget>[
            RaisedButton(
              onPressed: () => Navigator.pushNamed(context, SignupView.id),
              child: const Text('Signup'),
            ),
            RaisedButton(
              onPressed: () => Navigator.pushNamed(context, LoginView.id),
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
