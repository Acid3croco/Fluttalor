import 'package:flutter/material.dart';

import 'package:fluttalor/views/contact_list/contact_list.dart';

class LoginView extends StatelessWidget {
  static const String id = '/login_view';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: <Widget>[
          RaisedButton(
            onPressed: () => Navigator.of(context).pushNamedAndRemoveUntil(
                ContactList.id, (Route<dynamic> route) => false),
            child: const Text('Contact List'),
          ),
        ],
      ),
    );
  }
}
