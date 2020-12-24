import 'package:fluttalor/api/authentificationService.dart';
import 'package:fluttalor/views/authentication/authentication.dart';
import 'package:flutter/material.dart';

class ContactModalView extends StatefulWidget {
  static const String id = '/contact_tile';

  @override
  _ContactModalViewState createState() => _ContactModalViewState();
}

class _ContactModalViewState extends State<ContactModalView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.75,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25.0),
          topRight: Radius.circular(25.0),
        ),
      ),
      child: SafeArea(
        minimum: const EdgeInsets.only(left: 20, right: 20, top: 20),
        child: Column(
          children: <Widget>[
            const Text('bonjour'),
            const Text('bonjour'),
            const Text('bonjour'),
            const Text('bonjour'),
            ElevatedButton(
              child: const Text('Deconnexion'),
              onPressed: () async {
                AuthService.logout();
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  AuthenticationView.id,
                  (Route<dynamic> route) => false,
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
