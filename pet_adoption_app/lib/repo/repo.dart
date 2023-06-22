// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:pet_adoption_app/db/data.dart';
import 'package:pet_adoption_app/model/pet_model.dart';

/// Per Datas repositery
class PetRepo with ChangeNotifier {
  /// Getitng pet data from db
  Future<List<PetModel>> getPetData(
      {String searchTxt = "",
      int offset = 0,
      int? limit,
      List<String> ids = const []}) async {
    Future.delayed(const Duration(seconds: 2));
    final datas = pets
        .map((e) => PetModel.fromMap(e))

        /// Searching by txt
        .where((e) {
      return '${e.name}_${e.id}'
              .toLowerCase()
              .contains(searchTxt.toLowerCase()) &&
          (ids.isEmpty ? true : ids.contains(e.id));
    }).toList();
    return datas.limit(limit: limit, offset: offset);
  }

  /// get pet by id
  Future<PetModel> getById(String id) async {
    return pets.map((e) => PetModel.fromMap(e)).firstWhere((e) => e.id == id);
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
