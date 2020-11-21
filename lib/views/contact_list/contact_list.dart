import 'package:fluttalor/views/authentication_views/authentication_view.dart';
import 'package:flutter/material.dart';

import 'package:fluttalor/views/contact_handler/contact_handler.dart';

class ContactList extends StatelessWidget {
  static const String id = '/contact_list';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            const Text('Contact list'),
            RaisedButton(
                onPressed: () =>
                    Navigator.pushNamed(context, AuthenticationView.id))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, ContactHandler.id),
        child: const Icon(Icons.add),
      ),
    );
  }
}
