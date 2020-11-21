import 'package:flutter/material.dart';

class ContactHandler extends StatelessWidget {
  static const String id = '/contact_handler';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add'),
      ),
      body: Center(
        child: Container(
          child: const Text('Contact handler'),
        ),
      ),
    );
  }
}
