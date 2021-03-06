import 'package:fluttalor/classes/label.dart';

class Contact {
  Contact(
      int pk,
      String nickname,
      String firstname,
      String lastname,
      String phone,
      String email,
      String address,
      String icon,
      List<dynamic> labels,
      bool profile) {
    _pk = pk;
    _nickname = nickname;
    _firstname = firstname;
    _lastname = lastname;
    _phone = phone;
    _email = email;
    _address = address;
    _icon = icon;
    _profile = profile;
    setLabel(labels);
  }

  int _pk;
  String _nickname;
  String _firstname;
  String _lastname;
  String _phone;
  String _email;
  String _address;
  String _icon;
  bool _profile;
  List<Label> _labels;

  int get pk => _pk;
  String get nickname => _nickname;
  String get firstname => _firstname;
  String get lastname => _lastname;
  String get phone => _phone;
  String get email => _email;
  String get address => _address;
  String get icon => _icon;
  bool get profile => _profile;
  List<Label> get labels => _labels;

  void modifyContact(Map<String, String> newInfo) {
    newInfo.forEach((String key, String value) {
      switch (key) {
        case 'nickname':
          {
            _nickname = value;
          }
          break;
        case 'firstname':
          {
            _firstname = value;
          }
          break;
        case 'lastname':
          {
            _lastname = value;
          }
          break;
        case 'phone':
          {
            _phone = value;
          }
          break;
        case 'email':
          {
            _email = value;
          }
          break;
        case 'address':
          {
            _address = value;
          }
          break;
        case 'icon':
          {
            _icon = value;
          }
          break;
        default:
          {
            print('Champs $key non connue.');
          }
          break;
      }
    });
  }

  void setLabel(List<dynamic> labels) {
    final List<Label> labelList = <Label>[];

    for (final dynamic label in labels) {
      labelList.add(Label(
        label['pk'] as int,
        label['name'] as String,
      ));
    }

    _labels = labelList;
  }

  List<dynamic> getLabelsPk() {
    final List<dynamic> labelList = <dynamic>[];

    for (final Label label in _labels) {
      labelList.add(label.pk);
    }

    return labelList;
  }

  String getContactName() {
    String name = '';

    for (final String tmp in <String>[firstname, nickname, lastname]) {
      if (tmp.isNotEmpty) {
        if (name.isNotEmpty) {
          name += ' ';
        }
        name += tmp;
      }
    }
    return name;
  }
}
