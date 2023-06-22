import 'db.dart';
import 'models/user.dart';

class RestData {
  Future<User?> login(String username, String password) async {
    var db = DatabaseHelper();
    final userRetorno = await db.checkUser(username, password);
    return userRetorno;
  }
}
