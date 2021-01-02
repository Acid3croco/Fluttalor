import 'package:fluttalor/api/authentificationService.dart';
import 'package:fluttalor/views/authentication/authentication.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:fluttalor/utils/colors.dart';
import 'package:fluttalor/classes/label.dart';
import 'package:fluttalor/classes/contact.dart';
import 'package:fluttalor/api/contactService.dart';
import 'package:fluttalor/providers/contactListModel.dart';
import 'package:fluttalor/views/contact_list/contact_tile.dart';
import 'package:fluttalor/views/contact_handler/contact_handler.dart';

class ContactModal extends StatelessWidget {
  const ContactModal({
    Key key,
    @required this.contact,
  }) : super(key: key);

  final Contact contact;

  Future<void> _launchUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<void> _launchPhone() async {
    final String url = 'tel:${contact.phone}';

    if (contact.phone.isEmpty) {
      print('No phone number provided');
      return;
    }
    try {
      await _launchUrl(url);
    } catch (e) {
      print('error in _launchPhone: $e');
    }
  }

  Future<void> _launchEmail() async {
    final String url = 'mailto:${contact.email}';

    if (contact.email.isEmpty) {
      print('No email provided');
      return;
    }
    try {
      await _launchUrl(url);
    } catch (e) {
      print('error in _launchEmail: $e');
    }
  }

  ImageProvider _getContactImage() {
    if (contact != null && contact.icon != null) {
      try {
        return NetworkImage(contact.icon);
      } catch (e) {
        return null;
      }
    }
    return null;
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
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Stack(
                alignment: Alignment.topCenter,
                children: <Widget>[
                  CircleAvatar(
                    radius: 80,
                    backgroundImage: _getContactImage(),
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
                                width: 50,
                                height: 50,
                                child: RawMaterialButton(
                                  onPressed: () {
                                    Navigator.popAndPushNamed(
                                        context, ContactHandlerView.id,
                                        arguments:
                                            ContactHandlerArguments(contact));
                                  },
                                  child: Icon(
                                    Icons.edit_outlined,
                                    size: 28,
                                    color: myBlue,
                                  ),
                                ),
                              ),
                            ),
                            ClipOval(
                              child: Container(
                                width: 50,
                                height: 50,
                                child: RawMaterialButton(
                                  onPressed: () {
                                    _showMaterialDialog(
                                        context, contact, contact.profile);
                                  },
                                  child: Icon(
                                    contact.profile
                                        ? Icons.logout
                                        : Icons.delete_forever_outlined,
                                    size: 28,
                                    color: myRed,
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
                      contact.getContactName(),
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
                    maxLines: null,
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
              RawMaterialButton(
                onPressed: () => _launchEmail(),
                child: Container(
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
                    maxLines: null,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.email_outlined),
                      labelText: 'Email',
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      filled: false,
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                    ),
                    initialValue: contact.email,
                  ),
                ),
              ),
              RawMaterialButton(
                onPressed: () =>
                    Clipboard.setData(ClipboardData(text: contact.address)),
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, top: 5, bottom: 5),
                  child: TextFormField(
                    maxLines: null,
                    enabled: false,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.map_outlined),
                      labelText: 'Adresse',
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      filled: false,
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                    ),
                    initialValue: contact.address,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Future<void> _showMaterialDialog(
    BuildContext context, Contact contact, bool profile) {
  return showDialog(
    context: context,
    builder: (_) => AlertDialog(
      content: profile
          ? const Text('Se déconnecter ?')
          : const Text('Supprimer ce contact ?'),
      actions: <Widget>[
        FlatButton(
          child: const Text('Annuler'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        FlatButton(
          child: profile
              ? Text(
                  'Déconnecter',
                  style: TextStyle(
                    color: myRed,
                  ),
                )
              : Text(
                  'Supprimer',
                  style: TextStyle(
                    color: myRed,
                  ),
                ),
          onPressed: () {
            if (profile) {
              AuthService.logout();
              Navigator.pushNamedAndRemoveUntil(
                context,
                AuthenticationView.id,
                (Route<dynamic> route) => false,
              );
            } else {
              ContactService.removeContact(contact.pk);
              context.read<ContactList>().removeContact(contact);
              Navigator.pop(context);
              Navigator.pop(context);
            }
          },
        ),
      ],
    ),
  );
}
