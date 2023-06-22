import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_adoption_app/src/details/details_pg.dart';
import 'package:pet_adoption_app/src/home/bloc/home_bloc.dart';
import 'package:pet_adoption_app/provider/adoption.dart';
import 'package:pet_adoption_app/repo/repo.dart';
import 'package:pet_adoption_app/utils/theme/theme.dart';

/// History Bloc
class HistoryBloc extends Cubit<HomeState> {
  BuildContext context;
  HistoryBloc(this.context) : super(LoadingState()) {
    loadData();
  }
  PetRepo repo = PetRepo();

  /// Loading Data
  Future<void> loadData() async {
    final datas = await Provider.of<AdoptionProvider>(context).getAdopted();
    Future.delayed(const Duration(seconds: 2));
    emit(DataLoadedState(datas: datas));
  }

  /// on tap details
  void onTapDetails(String id, BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Details(id: id)),
    );
  }
}
