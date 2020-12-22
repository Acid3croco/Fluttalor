// import 'package:fluttalor/views/authentication_views/authentication_view.dart';
import 'package:flutter/material.dart';

import 'package:badges/badges.dart';

import 'package:fluttalor/views/contact_handler/contact_handler.dart';

class ContactList extends StatelessWidget {
  static const String id = '/contact_list';

  final List<String> names = <String>['Pierre', 'Michelle', 'Yoann', 'Damz'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contacts'),
        actions: const <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 20),
            child: Icon(Icons.search),
          )
        ],
      ),
      body: ListView.builder(
        itemCount: names.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                    color: index < names.length - 1
                        ? Colors.black12
                        : Colors.transparent),
              ),
            ),
            child: ListTile(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              leading: const CircleAvatar(
                radius: 30,
              ),
              title: Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: Text(
                  names[index],
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
              ),
              subtitle: Row(
                children: const <Widget>[
                  ContactBadge(name: 'AMI'),
                  ContactBadge(name: 'AMI'),
                  ContactBadge(name: 'AMI'),
                ],
              ),
            ),
          );
        },
        // separatorBuilder: (BuildContext context, int index) {
        //   return const Divider(
        //     thickness: 1,
        //   );
        // },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, ContactHandler.id),
        child: const Icon(Icons.add),
      ),
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
        badgeColor: Colors.green,
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
