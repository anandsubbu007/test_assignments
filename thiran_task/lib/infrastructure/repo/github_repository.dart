import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:thiran_task/application/service/http_service.dart';
import 'package:thiran_task/domain/model/github_response.dart';
import 'package:thiran_task/presentation/utilities/app_function.dart';
import '../../domain/di/app_preferences.dart';

abstract class GithubRepositoryInterface {
  Future<dynamic> getGithubRepository({required String url});
}

class GithubRepository implements GithubRepositoryInterface {
  final HttpService _http = HttpService();

  GithubRepository();

  @override
  Future getGithubRepository({required String url}) async {
    try {
      http.Response response = await _http.get(url);
      final link = response.headers["link"]!.parseLink();
      if (link.containsKey("next")) {
        await AppPreferences.instance.setLastPage(false);
        await AppPreferences.instance.setNextPageUrl(link["next"]!);
      } else {
        await AppPreferences.instance.setLastPage(true);
      }

      return GithubResponse.fromJson(jsonDecode(response.body)).items;
    } catch (e) {
      return e;
    }
  }
}
