import 'package:fluttalor/classes/label.dart';

class Contact {
  Contact(int pk, String nickname, String firstname, String lastname,
      String phone, String email, List<Label> labels) {
    _pk = pk;
    _nickname = nickname;
    _firstname = firstname;
    _lastname = lastname;
    _phone = phone;
    _email = email;
    _labels = labels;
  }

  int _pk;
  String _nickname;
  String _firstname;
  String _lastname;
  String _phone;
  String _email;
  List<Label> _labels;

  int get pk => _pk;
  String get nickname => _nickname;
  String get firstname => _firstname;
  String get lastname => _lastname;
  String get phone => _phone;
  String get email => _email;
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
        default:
          {
            print('Champs $key non connue.');
          }
          break;
      }
    });
  }

  void addLabel(Label label) {
    _labels.add(label);
  }

  void removeLabel(int labelPk) {
    for (final Label label in _labels) {
      if (label.pk == labelPk) {
        _labels.remove(label);
      }
    }
  }
}
