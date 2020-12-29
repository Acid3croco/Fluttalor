import 'package:fluttalor/api/contactService.dart';
import 'package:provider/provider.dart';
import 'package:fluttalor/classes/contact.dart';
import 'package:fluttalor/providers/contactListModel.dart';
import 'package:fluttalor/utils/custom_shadows.dart';
import 'package:flutter/material.dart';

class ContactHandlerView extends StatefulWidget {
  static const String id = '/contact_handler';

  @override
  _ContactHandlerViewState createState() => _ContactHandlerViewState();
}

class _ContactHandlerViewState extends State<ContactHandlerView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _nickname = TextEditingController();
  final TextEditingController _firstname = TextEditingController();
  final TextEditingController _lastname = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  final TextEditingController _email = TextEditingController();

  bool _formValid = true;
  bool _nullField = false;

  void _submit() {
    if (_nickname.text == null &&
        _firstname.text == null &&
        _lastname.text == null) {
      _nullField = true;
    }

    _formKey.currentState.validate();
    if (_formValid) {
      ContactService.createContact(_nickname.text, _firstname.text,
              _lastname.text, _phone.text, _email.text)
          .then((Contact result) {
        if (result != null) {
          print('Submit success');
          _formKey.currentState.reset();
          context.read<ContactList>().addContact(result);
          Navigator.pop(context);
        } else {
          _formKey.currentState.validate();
          print('Submit fail');
        }
      });
    } else {
      print('Submit fail');
    }
    // setState(() {
    //   _formValid = true;
    // });
  }

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
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                TextFormField(
                  controller: _nickname,
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.people_outline),
                      labelText: 'Surnom',
                      border: OutlineInputBorder()),
                  validator: (String value) {
                    if (_nullField) {
                      return "Vous devez remplir au moins l'un de ses champs.";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _firstname,
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.people_outline),
                      labelText: 'Prénom',
                      border: OutlineInputBorder()),
                  validator: (String value) {
                    if (_nullField) {
                      return "Vous devez remplir au moins l'un de ses champs.";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _lastname,
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.people_outline),
                      labelText: 'Nom de famille',
                      border: OutlineInputBorder()),
                  validator: (String value) {
                    if (_nullField) {
                      setState(() {
                        _nullField = false;
                      });
                      return "Vous devez remplir au moins l'un de ses champs.";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _phone,
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.photo_outlined),
                      labelText: 'numéro de telephone',
                      border: OutlineInputBorder()),
                  keyboardType: TextInputType.number,
                  validator: (String value) {
                    if (value.length < 5) {
                      setState(() {
                        _formValid = false;
                      });
                      return 'Un numéro de telephone dois avoir au minimum 5 nombres.';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _email,
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.mail_outline),
                      labelText: 'Addresse email',
                      border: OutlineInputBorder()),
                  keyboardType: TextInputType.emailAddress,
                  validator: (String value) {
                    if (value.trim().isNotEmpty && !value.contains('@')) {
                      return 'Email non valide, vous devez avoir un @.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 30),
                Container(
                  child: ElevatedButton(
                    onPressed: _submit,
                    child: const Text('Ajouter contact'),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    boxShadow: customShadow[1],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
