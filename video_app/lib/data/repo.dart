import 'package:video_app/data/datas.dart';
import 'package:video_app/domain/model.dart';

/// Repo for Datas
class Repo {
  static final Repo _singleton = Repo._internal();
  factory Repo() => _singleton;
  Repo._internal();

  /// geting data to show in Home page
  Future<Model> getHomePgModels() async {
    return data;
  }
}
