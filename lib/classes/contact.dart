import 'package:fluttalor/classes/label.dart';

class Contact {
  Contact(int pk, String nickname, String firstname, String lastname,
      String phone, String email, String icon, List<dynamic> labels) {
    // final List<Label> labelList = <Label>[];

    // for (final dynamic label in labels) {
    //   labelList.add(Label(
    //     label['pk'] as int,
    //     label['name'] as String,
    //   ));
    // }

    _pk = pk;
    _nickname = nickname;
    _firstname = firstname;
    _lastname = lastname;
    _phone = phone;
    _email = email;
    _icon = icon;
    setLabel(labels);
    // _labels = labelList;
  }

  int _pk;
  String _nickname;
  String _firstname;
  String _lastname;
  String _phone;
  String _email;
  String _icon;
  List<Label> _labels;

  int get pk => _pk;
  String get nickname => _nickname;
  String get firstname => _firstname;
  String get lastname => _lastname;
  String get phone => _phone;
  String get email => _email;
  String get icon => _icon;
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
}
