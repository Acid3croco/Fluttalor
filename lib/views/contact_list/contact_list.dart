import 'package:fluttalor/api/labelService.dart';
import 'package:fluttalor/providers/contactListModel.dart';
import 'package:fluttalor/providers/labelListModel.dart';
import 'package:fluttalor/views/contact_list/contact_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:fluttalor/views/contact_handler/contact_handler.dart';

import 'package:fluttalor/api/contactService.dart';

class ContactListView extends StatefulWidget {
  static const String id = '/contact_list';

  @override
  _ContactListViewState createState() => _ContactListViewState();
}

class _ContactListViewState extends State<ContactListView> {
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
      body: FutureBuilder(
        future: ContactService.getContacts(),
        builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
          if (snapshot.hasData) {
            // WidgetsBinding.instance.addPostFrameCallback((_) {
            //   context.read<ContactList>().setContacts(snapshot.data);
            //   LabelService.getLabels().then((List<dynamic> labels) {
            //     if (labels != null) {
            //       context.read<LabelList>().setLabels(labels);
            //     }
            //   });
            // });

            return ListView.builder(
              itemCount: context.watch<ContactList>().getLength(),
              itemBuilder: (BuildContext context, int index) {
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
                  child: ContactTileView(
                    index: index,
                    contact:
                        context.watch<ContactList>().getContactFromIndex(index),
                  ),
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
        onPressed: () => Navigator.pushNamed(context, ContactHandler.id),
        child: const Icon(Icons.add),
      ),
    );
  }
}
