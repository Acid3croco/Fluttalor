import 'package:flutter/material.dart';

import 'package:badges/badges.dart';

import 'package:fluttalor/utils/colors.dart';
import 'package:fluttalor/classes/label.dart';
import 'package:fluttalor/classes/contact.dart';
import 'package:fluttalor/views/contact_list/contact_modal.dart';

class ContactTile extends StatelessWidget {
  const ContactTile({
    Key key,
    @required this.contact,
  }) : super(key: key);

  final Contact contact;

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
    return ListTile(
      tileColor: contact.profile ? myGreyLight : null,
      contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      leading: CircleAvatar(
        radius: 30,
        backgroundImage: _getContactImage(),
      ),
      title: (contact != null)
          ? Text(
              contact.getContactName(),
              style: const TextStyle(fontWeight: FontWeight.w500),
            )
          : const Text(''),
      subtitle: (contact != null && contact.labels.isNotEmpty)
          ? Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Row(
                children: <Widget>[
                  for (final Label label in contact.labels)
                    ContactBadge(name: label.name)
                ],
              ),
            )
          : null,
      onTap: () => <void>{
        showModalBottomSheet<Widget>(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (BuildContext context) {
            return ContactModal(contact: contact);
          },
        ),
      },
    );
  }
}

class ContactBadge extends StatelessWidget {
  const ContactBadge({
    Key key,
    @required this.name,
  }) : super(key: key);

  final String name;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 5),
      child: Badge(
        elevation: 0,
        toAnimate: false,
        shape: BadgeShape.square,
        badgeColor: myGreen,
        borderRadius: BorderRadius.circular(50),
        badgeContent: Text(
          name,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}
