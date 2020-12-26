import 'package:badges/badges.dart';
import 'package:fluttalor/classes/contact.dart';
import 'package:fluttalor/classes/label.dart';
import 'package:fluttalor/utils/colors.dart';
import 'package:fluttalor/views/contact_list/contact_modal.dart';
import 'package:flutter/material.dart';

class ContactTileView extends StatefulWidget {
  const ContactTileView({this.index, this.contact});

  final int index;
  final Contact contact;

  static const String id = '/contact_tile';

  @override
  _ContactTileViewState createState() => _ContactTileViewState();
}

class _ContactTileViewState extends State<ContactTileView> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      leading: const CircleAvatar(
        radius: 30,
      ),
      title: Padding(
        padding: const EdgeInsets.only(bottom: 5),
        child: Column(
          children: <Widget>[
            Text(
              widget.contact.nickname,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
            Text(
              widget.contact.firstname,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
            Text(
              widget.contact.lastname,
              style: const TextStyle(fontWeight: FontWeight.w500),
            )
          ],
        ),
      ),
      subtitle: Row(
        children: <Widget>[
          if (widget.contact.labels.isNotEmpty)
            for (final Label label in widget.contact.labels)
              ContactBadge(name: label.name)
          else
            Container(),
        ],
      ),
      onTap: () => <void>{
        showModalBottomSheet<Widget>(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (BuildContext context) {
            return ContactModalView();
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
