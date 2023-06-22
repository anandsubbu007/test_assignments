import 'dart:convert';
import 'package:goto_app/src/model/data_model.dart';
import 'package:http/http.dart' as http;

enum SortBy {
  star('stars', 'stars'),
  name('name', 'name');

  final String title;
  final String param;
  const SortBy(this.title, this.param);
}

class GitApiService {
  static final GitApiService _singleton = GitApiService._internal();
  static GitApiService instance = GitApiService();
  factory GitApiService() => _singleton;

  GitApiService._internal();

  String url(String sortBy) {
    return 'https://api.github.com/orgs/octokit/repos?sort=$sortBy';
  }

  Future<List<RepoDataM>> retriveApiData(SortBy sortBy) async {
    var response = await http.get(Uri.parse(url(sortBy.param)));
    List<RepoDataM> repos = [];
    if (response.statusCode != 404) {
      var res = jsonDecode(response.body) as List;
      for (var element in res) {
        var repo = RepoDataM.fromJson(element);
        repos.add(repo);
      }
      return repos;
    }
    return List.empty();
  }
}
