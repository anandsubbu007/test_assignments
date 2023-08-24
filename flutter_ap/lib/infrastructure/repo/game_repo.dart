// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:flutter_ap/infrastructure/api_service/api_service.dart';
import 'package:flutter_ap/model/game_model.dart';

/// Per Datas repositery
class GameRepo with ChangeNotifier {
  /// Getitng game data from db
  Future<List<GamesModel>> getData(
      {String searchTxt = "",
      int page = 0,
      List<int>? generes,
      List<int>? platofrms}) async {
   return await ApiService.getData(
        page: page,
        generes: generes ?? [],
        platofrms: platofrms ?? [],
        searchTxt: searchTxt);
  }


  /// get game by id
  Future<GamesModel> getById(int id) async {
    final data = await ApiService.getDataById(id: id);
    return data;
  }
}

extension LimitExtOnApp<T> on List<T> {
  List<T> limit({int? limit, int offset = 0}) {
    if (limit == null) {
      if (offset > length) {
        return [];
      }
      return sublist(offset);
    } else if (offset == 0) {
      if (limit > length) return this;
    } else {
      if (offset > length) return [];
      if (limit > (length - offset)) return sublist(offset);
    }
    return sublist(offset, offset + limit);
  }
}
