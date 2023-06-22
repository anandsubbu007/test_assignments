import 'package:goto_app/src/model/data_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalDb {
  static final LocalDb _singleton = LocalDb._internal();
  static LocalDb instance = LocalDb();
  factory LocalDb() => _singleton;

  LocalDb._internal();

  Future init() async {
    prefs = await SharedPreferences.getInstance();
  }

  initSync(SharedPreferences sharedPref) {
    prefs = sharedPref;
  }

  late SharedPreferences prefs;

  Future<void> saveGithubRepo(List<RepoDataM> data) async {
    final dataEncoded = data.map((x) => x.toMap()).toList();
    // print('dataEncoded: $dataEncoded');
    await prefs.setStringList('data', dataEncoded);
  }

  Future<List<RepoDataM>> getGithubRepo() async {
    final items = prefs.getStringList('data');
    return items?.map((e) => RepoDataM.fromMap(e)).toList() ?? [];
  }
}
