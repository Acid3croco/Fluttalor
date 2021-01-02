import 'dart:io';

import 'package:flutter/material.dart';

import 'package:geocoder/geocoder.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:geolocator/geolocator.dart';
import 'package:multiselect_formfield/multiselect_formfield.dart';

import 'package:fluttalor/classes/contact.dart';
import 'package:fluttalor/api/contactService.dart';
import 'package:fluttalor/providers/labelListModel.dart';
import 'package:fluttalor/providers/contactListModel.dart';

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
  File _image;
  final ImagePicker picker = ImagePicker();

  Future<void> getImage() async {
    final PickedFile pickedFile =
        await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  void _createContact() {
    ContactService.createContact(
            _nickname.text,
            _firstname.text,
            _lastname.text,
            _phone.text,
            _email.text,
            _address.text,
            _labelsList,
            _image)
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
            _labelsList,
            _image)
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

  Future<void> _findAddress() async {
    final Position position = await Geolocator.getCurrentPosition();
    final Coordinates coordinates =
        Coordinates(position.latitude, position.longitude);
    final List<Address> addresses =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    final Address first = addresses.first;

    _address.text = first.addressLine;
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
            ? widget.contact.profile
                ? const Text('Modifier mon profil')
                : const Text('Modifier contact')
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
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 10),
                child: GestureDetector(
                  onTap: getImage,
                  child: CircleAvatar(
                    radius: 80,
                    child: _image == null
                        ? const Icon(
                            Icons.add_a_photo_outlined,
                            size: 50,
                          )
                        : null,
                    backgroundImage: backgroundImageGetter(),
                  ),
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
                  maxLines: null,
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
                  maxLines: null,
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
                  maxLines: null,
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
                  maxLines: null,
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
                  maxLines: null,
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
                  maxLines: null,
                  controller: _address,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Icons.map_outlined,
                    ),
                    suffixIcon: ClipOval(
                      child: GestureDetector(
                        onTap: () => _findAddress(),
                        child: const Icon(Icons.my_location),
                      ),
                    ),
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
    );
  }

  ImageProvider backgroundImageGetter() {
    if (_image != null) {
      return FileImage(_image);
    } else if (contact != null && contact.icon != null) {
      return NetworkImage(contact.icon);
    } else {
      return null;
    }
  }
}

class ContactHandlerArguments {
  ContactHandlerArguments(this.contact);

  final Contact contact;
}
