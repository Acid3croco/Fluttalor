import 'package:fluttalor/api/authentificationService.dart';
import 'package:fluttalor/classes/contact.dart';
import 'package:fluttalor/views/authentication/authentication.dart';
import 'package:flutter/material.dart';

class ContactModal extends StatelessWidget {
  const ContactModal({
    Key key,
    @required this.contact,
  }) : super(key: key);

  final Contact contact;

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
            CircleAvatar(
              radius: 30,
              backgroundImage:
                  contact.icon != null ? NetworkImage(contact.icon) : null,
            ),
            Text(contact.nickname),
            Text(contact.firstname),
            Text(contact.lastname),
            Text(contact.email),
            Text(contact.phone),
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
