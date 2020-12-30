import 'package:url_launcher/url_launcher.dart';

import 'package:fluttalor/classes/contact.dart';
import 'package:fluttalor/classes/label.dart';
import 'package:fluttalor/utils/colors.dart';
import 'package:fluttalor/views/contact_list/contact_tile.dart';
import 'package:flutter/material.dart';

class ContactModal extends StatelessWidget {
  const ContactModal({
    Key key,
    @required this.contact,
  }) : super(key: key);

  final Contact contact;

  String _buildContactName() {
    String name = '';

    if (contact.firstname.isNotEmpty) {
      name += contact.firstname;
    }
    if (contact.nickname.isNotEmpty) {
      if (name.isNotEmpty) {
        name += ' ';
      }
      name += contact.nickname;
    }
    if (contact.lastname.isNotEmpty) {
      if (name.isNotEmpty) {
        name += ' ';
      }
      name += contact.lastname;
    }
    return name;
  }

  Future<void> _launchPhone() async {
    // final String url = 'tel:${contact.phone}';
    const String url =
        'mailto:smith@example.org?subject=News&body=New%20plugin';

    // if (contact.phone.isEmpty) {
    //   print('No phone number provided');
    //   return;
    // }
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

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
        minimum: const EdgeInsets.only(top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Stack(
              alignment: Alignment.topCenter,
              children: <Widget>[
                CircleAvatar(
                  radius: 80,
                  backgroundImage:
                      contact.icon != null ? NetworkImage(contact.icon) : null,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          ClipOval(
                            child: Container(
                              width: 40,
                              height: 40,
                              child: RawMaterialButton(
                                onPressed: () => print('biensur'),
                                child: Icon(
                                  Icons.edit_outlined,
                                  size: 28,
                                  color: myDark,
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 20,
                bottom: 0,
                left: 57,
                right: 30,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    _buildContactName(),
                    style: const TextStyle(
                      fontSize: 32,
                    ),
                  ),
                  if (contact.labels.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Row(
                        children: <Widget>[
                          for (final Label label in contact.labels)
                            ContactBadge(name: label.name)
                        ],
                      ),
                    )
                ],
              ),
            ),
            RawMaterialButton(
              onPressed: () => _launchPhone(),
              child: Container(
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.black12,
                    ),
                  ),
                ),
                padding: const EdgeInsets.only(left: 10, top: 5, bottom: 5),
                child: TextFormField(
                  enabled: false,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.phone_outlined),
                    labelText: 'Numéro de téléphone',
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    filled: false,
                  ),
                  initialValue: contact.phone,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 10, top: 5, bottom: 5),
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.black12,
                  ),
                ),
              ),
              child: TextFormField(
                enabled: false,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.email_outlined),
                  labelText: 'Email',
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  filled: false,
                ),
                initialValue: contact.email,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, top: 5, bottom: 5),
              child: TextFormField(
                enabled: false,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.map_outlined),
                  labelText: 'Adresse',
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  filled: false,
                ),
                // initialValue: contact.address,
              ),
            ),
            // ElevatedButton(
            //   child: const Text('Deconnexion'),
            //   onPressed: () async {
            //     AuthService.logout();
            //     Navigator.pushNamedAndRemoveUntil(
            //       context,
            //       AuthenticationView.id,
            //       (Route<dynamic> route) => false,
            //     );
            //   },
            // )
          ],
        ),
      ),
    );
  }
}
