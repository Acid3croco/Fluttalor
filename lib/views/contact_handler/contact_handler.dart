import 'package:fluttalor/api/contactService.dart';
import 'package:fluttalor/providers/labelListModel.dart';
import 'package:provider/provider.dart';
import 'package:fluttalor/classes/contact.dart';
import 'package:fluttalor/providers/contactListModel.dart';
// import 'package:fluttalor/utils/custom_shadows.dart';
import 'package:flutter/material.dart';
import 'package:multiselect_formfield/multiselect_formfield.dart';

class ContactHandlerView extends StatefulWidget {
  const ContactHandlerView({Key key, this.contact}) : super(key: key);

  final Contact contact;

  static const String id = '/contact_handler';

  @override
  _ContactHandlerViewState createState() => _ContactHandlerViewState();
}

class _ContactHandlerViewState extends State<ContactHandlerView> {
  Contact contact;
  bool _modify = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController _nickname;
  TextEditingController _firstname;
  TextEditingController _lastname;
  TextEditingController _phone;
  TextEditingController _email;

  List<dynamic> _labelsList = <dynamic>[];

  bool _formValid = true;
  bool _nullField = false;

  void _createContact() {
    ContactService.createContact(_nickname.text, _firstname.text,
            _lastname.text, _phone.text, _email.text, _labelsList)
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
  }

  void _modifyContact() {
    ContactService.modifyContact(contact, _nickname.text, _firstname.text,
            _lastname.text, _phone.text, _email.text, _labelsList)
        .then((Contact result) {
      if (result != null) {
        print('Submit success');
        _formKey.currentState.reset();
        context.read<ContactList>().modifyContact();
        Navigator.pop(context);
      } else {
        _formKey.currentState.validate();
        print('Submit fail');
      }
    });
  }

  void _submit() {
    if (_nickname.text == null &&
        _firstname.text == null &&
        _lastname.text == null) {
      _nullField = true;
    }

    if (_formKey.currentState.validate()) {
      if (_modify)
        _modifyContact();
      else
        _createContact();
    } else {
      print('Submit fail');
    }
    setState(() {
      _formValid = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      final dynamic args = ModalRoute.of(context).settings.arguments;

      String nicknameInit = '';
      String firstnameInit = '';
      String lastnameInit = '';
      String phoneInit = '';
      String emailInit = '';

      List<dynamic> labelsListInit = <dynamic>[];

      if (args != null && args['contact'] != null) {
        contact = args['contact'] as Contact;
        nicknameInit = contact.nickname;
        firstnameInit = contact.firstname;
        lastnameInit = contact.lastname;
        phoneInit = contact.phone;
        emailInit = contact.email;
        labelsListInit = contact.getLabelsPk();
        _modify = true;
      }

      _nickname = TextEditingController(text: nicknameInit);
      _firstname = TextEditingController(text: firstnameInit);
      _lastname = TextEditingController(text: lastnameInit);
      _phone = TextEditingController(text: phoneInit);
      _email = TextEditingController(text: emailInit);

      _labelsList = labelsListInit;
    });

    return Scaffold(
      appBar: AppBar(
        title: _modify ? const Text('Modification') : const Text('Ajout'),
        leadingWidth: 60,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: GestureDetector(
              onTap: _submit,
              child: const Icon(Icons.check),
            ),
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
                    if (value.isNotEmpty && value.length < 5) {
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
                MultiSelectFormField(
                  title: const Text('Tag'),
                  dataSource: context.watch<LabelList>().getLabelList(),
                  textField: 'display',
                  valueField: 'value',
                  okButtonLabel: 'AJOUT',
                  cancelButtonLabel: 'ANNULER',
                  hintWidget:
                      const Text('Choisissez un tag pour votre contact'),
                  initialValue: _labelsList,
                  onSaved: (dynamic value) {
                    if (value == null) {
                      return null;
                    }
                    setState(() {
                      _labelsList = value as List<dynamic>;
                    });
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
