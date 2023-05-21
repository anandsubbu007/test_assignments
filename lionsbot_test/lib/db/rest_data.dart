import 'db.dart';
import 'user.dart';

class RestData {
  Future<User?> login(String username, String password) async {
    var db = DatabaseHelper();
    final userRetorno = await db.checkUser(username, password);
    return userRetorno;
  }
}
