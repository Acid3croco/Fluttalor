import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:fluttalor/classes/contact.dart';
import 'package:fluttalor/api/labelService.dart';
import 'package:fluttalor/api/contactService.dart';
import 'package:fluttalor/providers/labelListModel.dart';
import 'package:fluttalor/providers/contactListModel.dart';
import 'package:fluttalor/views/contact_list/contact_tile.dart';
import 'package:fluttalor/views/contact_handler/contact_handler.dart';

class ContactListView extends StatefulWidget {
  static const String id = '/contact_list';

  @override
  _ContactListViewState createState() => _ContactListViewState();
}

class _ContactListViewState extends State<ContactListView> {
  Future<bool> getData(BuildContext context) async {
    List<List<dynamic>> results;

    results = await Future.wait([
      ContactService.getContacts(),
      LabelService.getLabels(),
    ]);

    if (results[0] != null) {
      context.read<ContactList>().setContacts(results[0]);
    } else {
      return false;
    }

    if (results[1] != null) {
      context.read<LabelList>().setLabels(results[1]);
    } else {
      return false;
    }

    return true;
  }

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
      body: FutureBuilder<bool>(
        future: getData(context),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: context.watch<ContactList>().getLength(),
              itemBuilder: (BuildContext context, int index) {
                final Contact currContact =
                    context.watch<ContactList>().getContactFromIndex(index);
                return Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                          color: index <
                                  context.watch<ContactList>().getLength() - 1
                              ? Colors.black12
                              : Colors.transparent),
                    ),
                  ),
                  child: ContactTile(contact: currContact),
                );
              },
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, ContactHandlerView.id),
        child: const Icon(Icons.add),
      ),
    );
  }
}
