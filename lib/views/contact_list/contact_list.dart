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
        actions: const <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 20),
            child: Icon(Icons.search),
          )
        ],
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            const Text('Contact list'),
            RaisedButton(
              onPressed: () =>
                  Navigator.pushNamed(context, AuthenticationView.id),
              child: const Text('Return to auth view'),
            )
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
