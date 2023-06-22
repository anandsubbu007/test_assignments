import 'package:flutter/material.dart';
import 'package:pet_adoption_app/db/storage_manager.dart';
import 'package:pet_adoption_app/model/pet_model.dart';
import 'package:pet_adoption_app/repo/repo.dart';

/// Pet Adoption handler
class AdoptionProvider with ChangeNotifier {
  PetRepo reop = PetRepo();
  AdoptionProvider() {
    /// loading data from cache
    adoptedIds = AppStorageManager.instance.prefs.getStringList(_adopted) ?? [];
  }

  /// get adopted datas
  Future<List<PetModel>> getAdopted(
      {String searchTxt = "", int offset = 0, int? limit}) async {
    if (adoptedIds.isEmpty) return [];
    return reop.getPetData(
        ids: adoptedIds, limit: limit, offset: offset, searchTxt: searchTxt);
  }

  static const String _adopted = "adopted";

  List<String> adoptedIds = [];

  /// adopt pet
  Future<bool> adopt(String id) async {
    adoptedIds.add(id);
    final isIt = await save();

    notifyListeners();
    return isIt;
  }

  /// clear all data
  Future removeAll() async {
    adoptedIds = [];
    await save();
    notifyListeners();
  }

  Future<bool> save() async {
    try {
      await AppStorageManager.instance.prefs
          .setStringList(_adopted, adoptedIds);
    } catch (e) {
      //
    }
    return true;
  }

  /// this pet [id] adopted
  bool isAdopted(String id) {
    return adoptedIds.contains(id);
  }
}
