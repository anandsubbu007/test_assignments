// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:flutter_ap/config/constants.dart';
import 'package:flutter_ap/model/game_model.dart';
import 'package:flutter_ap/model/geners.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static Future<List<GamesModel>> getData({
    int page = 1,
    int pageSize = 20,
    String? searchTxt,
    List<int> generes = const [],
    List<int> platofrms = const [],
  }) async {
    String url =
        "https://api.rawg.io/api/games?page_size=$pageSize&page=$page&key=${APIKeys.rawg}";
    if (searchTxt != null && searchTxt.isNotEmpty) {
      url += '&search=$searchTxt';
    } else {
      if (platofrms.isNotEmpty) {
        url += '&platforms=${platofrms.join(',')}';
      }
      if (generes.isNotEmpty) {
        url += '&genres=${generes.join(',')}';
      }
    }

    try {
      final response = await http.get(Uri.parse(url));
      final data = jsonDecode(response.body);
      List<GamesModel> models = [];
      print(response.body);
      if (data['results'] is List) {
        models = List.from(data['results'])
            .map((e) => GamesModel.fromMap(e))
            .toList();
      }
      if (models.isEmpty) {
        if ((data['detail']?.toString() ?? '').isNotEmpty) {
          return Future.error(data['detail']);
        }
      }
      print("$url ==> ${models.length}");
      return models;
    } catch (e) {
      return Future.error(e);
    }
  }

  static Future<GamesModel> getDataById({required int id}) async {
    final url = "https://api.rawg.io/api/games/$id?key=${APIKeys.rawg}";
    try {
      final response = await http.get(Uri.parse(url));
      final data = jsonDecode(response.body);
      return GamesModel.fromMap(data);
    } catch (e) {
      return Future.error(e);
    }
  }

  //
  static Future<List<GamePlatform>> getAllPlatoforms() async {
    String url = "https://api.rawg.io/api/platforms?key=${APIKeys.rawg}";
    try {
      final response = await http.get(Uri.parse(url));
      final data = jsonDecode(response.body);
      List<GamePlatform> models = [];
      if (data['results'] is List) {
        models = List.from(data['results'])
            .map((e) => GamePlatform.fromJson(e))
            .toList();
      }
      print("$url ==> ${models.length}");
      return models;
    } catch (e) {
      return Future.error(e);
    }
  }

  static Future<List<GameGeners>> getAllGeners() async {
    String url = "https://api.rawg.io/api/platforms?key=${APIKeys.rawg}";
    try {
      final response = await http.get(Uri.parse(url));
      final data = jsonDecode(response.body);
      List<GameGeners> models = [];
      if (data['results'] is List) {
        models = List.from(data['results'])
            .map((e) => GameGeners.fromJson(e))
            .toList();
      }
      print("$url ==> ${models.length}");
      return models;
    } catch (e) {
      return Future.error(e);
    }
  }
}
