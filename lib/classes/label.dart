class Label {
  Label(int pk, String name) {
    _pk = pk;
    _name = name;
  }

  int _pk;
  String _name;

  int get pk => _pk;
  String get name => _name;

  void modifyLabel(String name) {
    _name = name;
  }
}
