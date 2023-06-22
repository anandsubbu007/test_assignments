class User {
  late String _name;
  late String _username;
  late String _password;
  late String _pic;

  User(this._name, this._username, this._password, this._pic);

  User.map(dynamic obj) {
    _name = obj['name'];
    _username = obj['username'];
    _password = obj['password'];
    _pic = obj['pic'];
  }
  String get name => _name;
  String get username => _username;
  String get password => _password;
  String get pic => _pic;

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    map["username"] = _username;
    map["password"] = _password;
    map["name"] = _name;
    map["pic"] = _pic;
    return map;
  }
}
