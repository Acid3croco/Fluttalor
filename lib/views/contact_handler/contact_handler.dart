import 'package:fluttalor/api/contactService.dart';
import 'package:fluttalor/providers/labelListModel.dart';
import 'package:provider/provider.dart';
import 'package:fluttalor/classes/contact.dart';
import 'package:fluttalor/providers/contactListModel.dart';
import 'package:flutter/material.dart';
import 'package:multiselect_formfield/multiselect_formfield.dart';

class ContactHandlerView extends StatefulWidget {
  const ContactHandlerView({
    Key key,
    @required this.contact,
  }) : super(key: key);

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
  TextEditingController _address;

  List<dynamic> _labelsList = <dynamic>[];
  List<dynamic> _labelsListInit;

  bool _nullField = false;

  void _createContact() {
    ContactService.createContact(
            _nickname.text,
            _firstname.text,
            _lastname.text,
            _phone.text,
            _email.text,
            _address.text,
            _labelsList)
        .then((Contact result) {
      if (result != null) {
        print('Submit success');
        // _formKey.currentState.reset();
        context.read<ContactList>().addContact(result);
        Navigator.pop(context);
      } else {
        _formKey.currentState.validate();
        print('Submit fail');
      }
    });
  }

  void _modifyContact() {
    ContactService.modifyContact(
            contact,
            _nickname.text,
            _firstname.text,
            _lastname.text,
            _phone.text,
            _email.text,
            _address.text,
            _labelsList)
        .then((Contact result) {
      if (result != null) {
        // _formKey.currentState.reset();
        context.read<ContactList>().modifyContact();
        Navigator.pop(context);
      } else {
        _formKey.currentState.validate();
        print('Submit fail');
      }
    });
  }

  void _submit() {
    if ((_nickname.text == null || _nickname.text == '') &&
        (_firstname.text == null || _firstname.text == '') &&
        (_lastname.text == null || _lastname.text == '')) {
      _nullField = true;
    }

    if (_formKey.currentState.validate() && !_nullField) {
      if (_modify)
        _modifyContact();
      else
        _createContact();
    } else {
      print('validate fail: $_nullField');
    }
    setState(() {
      _nullField = false;
    });
  }

  @override
  void initState() {
    super.initState();

    String nicknameInit = '';
    String firstnameInit = '';
    String lastnameInit = '';
    String phoneInit = '';
    String emailInit = '';
    String addressInit = '';

    List<dynamic> labelsListInit = <dynamic>[];

    contact = widget.contact;

    if (contact != null) {
      nicknameInit = contact.nickname;
      firstnameInit = contact.firstname;
      lastnameInit = contact.lastname;
      phoneInit = contact.phone;
      emailInit = contact.email;
      addressInit = contact.address;
      labelsListInit = contact.getLabelsPk();
      _modify = true;
    }

    _nickname = TextEditingController(text: nicknameInit);
    _firstname = TextEditingController(text: firstnameInit);
    _lastname = TextEditingController(text: lastnameInit);
    _phone = TextEditingController(text: phoneInit);
    _email = TextEditingController(text: emailInit);
    _address = TextEditingController(text: addressInit);

    _labelsListInit = labelsListInit;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _modify
            ? const Text('Modifier contact')
            : const Text('Ajouter un contact'),
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
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.black12,
                      ),
                    ),
                  ),
                  child: TextFormField(
                    controller: _firstname,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.people_outlined),
                      labelText: 'Prénom',
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      filled: false,
                    ),
                    validator: (String value) {
                      if (_nullField) {
                        return "Vous devez remplir au moins l'un de ces champs.";
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.black12,
                      ),
                    ),
                  ),
                  child: TextFormField(
                    controller: _nickname,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.people_outlined),
                      labelText: 'Surnom',
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      filled: false,
                    ),
                    validator: (String value) {
                      if (_nullField) {
                        return "Vous devez remplir au moins l'un de ces champs.";
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.black12,
                      ),
                    ),
                  ),
                  child: TextFormField(
                    controller: _lastname,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.people_outlined),
                      labelText: 'Nom de famille',
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      filled: false,
                    ),
                    validator: (String value) {
                      if (_nullField) {
                        return "Vous devez remplir au moins l'un de ces champs.";
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.black12,
                      ),
                    ),
                  ),
                  child: TextFormField(
                    controller: _phone,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.phone_outlined),
                      labelText: 'Numéro de téléphone',
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      filled: false,
                    ),
                    keyboardType: TextInputType.number,
                    validator: (String value) {
                      if (value.isNotEmpty && value.length < 5) {
                        return 'Un numéro de telephone dois avoir au minimum 5 nombres.';
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.black12,
                      ),
                    ),
                  ),
                  child: TextFormField(
                    controller: _email,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.email_outlined),
                      labelText: 'Adresse email',
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      filled: false,
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (String value) {
                      if (value.trim().isNotEmpty && !value.contains('@')) {
                        return 'Email non valide, vous devez avoir un @.';
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.black12,
                      ),
                    ),
                  ),
                  child: TextFormField(
                    controller: _address,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.map_outlined),
                      labelText: 'Adresse postale',
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      filled: false,
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  child: MultiSelectFormField(
                    title: const Text('Tag'),
                    dataSource: context.watch<LabelList>().getLabelList(),
                    textField: 'display',
                    valueField: 'value',
                    okButtonLabel: 'Ajouter',
                    cancelButtonLabel: 'Annuler',
                    border: const OutlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                    hintWidget: const Text(
                        'Choisissez un ou plusieurs tag pour votre contact'),
                    initialValue: _labelsListInit,
                    onSaved: (dynamic value) {
                      if (value == null) {
                        return null;
                      }
                      setState(() {
                        _labelsList = value as List<dynamic>;
                      });
                    },
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

class ContactHandlerArguments {
  ContactHandlerArguments(this.contact);

  final Contact contact;
}
