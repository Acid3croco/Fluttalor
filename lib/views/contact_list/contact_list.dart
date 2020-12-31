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
import 'package:fluttalor/utils/custom_shadows.dart';

import 'package:pull_to_refresh/pull_to_refresh.dart';

class ContactListView extends StatefulWidget {
  static const String id = '/contact_list';

  @override
  _ContactListViewState createState() => _ContactListViewState();
}

class _ContactListViewState extends State<ContactListView> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  final GlobalKey _refresherKey = GlobalKey();

  Future<bool> getData() async {
    List<List<dynamic>> results;

    results = await Future.wait(<Future<List<dynamic>>>[
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
        titleSpacing: 20,
        actions: const <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 20),
            child: Icon(Icons.search),
          )
        ],
      ),
      body: FutureBuilder<bool>(
        future: getData(),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.hasData) {
            final int contactCount = context.watch<ContactList>().getLength();

            if (contactCount > 0) {
              return SmartRefresher(
                key: _refresherKey,
                controller: _refreshController,
                enablePullDown: true,
                physics: const BouncingScrollPhysics(),
                onRefresh: () async {
                  if (await getData()) {
                    _refreshController.refreshCompleted();
                  }
                },
                child: ListView.builder(
                  itemCount: contactCount,
                  itemBuilder: (BuildContext context, int index) {
                    final Contact currContact =
                        context.watch<ContactList>().getContactFromIndex(index);
                    return Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                              color: index <
                                      context.watch<ContactList>().getLength() -
                                          1
                                  ? Colors.black12
                                  : Colors.transparent),
                        ),
                      ),
                      child: ContactTile(contact: currContact),
                    );
                  },
                ),
              );
            } else {
              return Center(
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 3.5,
                    ),
                    const Padding(
                      padding: EdgeInsets.all(20),
                      child: Text(
                        "Vous n'avez aucun contact pour le moment",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Container(
                      child: ElevatedButton(
                        onPressed: () =>
                            Navigator.pushNamed(context, ContactHandlerView.id),
                        child: const Text('Ajouter un contact'),
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        boxShadow: customShadow[1],
                      ),
                    )
                  ],
                ),
              );
            }
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(15),
        child: Transform.scale(
          scale: 1.15,
          child: FloatingActionButton(
            onPressed: () =>
                Navigator.pushNamed(context, ContactHandlerView.id),
            child: const Icon(
              Icons.add,
              size: 40,
            ),
          ),
        ),
      ),
    );
  }
}
