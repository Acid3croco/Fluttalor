import 'package:flutter/material.dart';

class ContactHandler extends StatelessWidget {
  static const String id = '/contact_handler';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add'),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: const Icon(Icons.check)),
          )
        ],
      ),
      body: Center(
        child: Container(
          child: const Text('Contact handler'),
        ),
      ),
    );
  }
}
