// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_adoption_app/src/details/details_pg.dart';
import 'package:pet_adoption_app/src/history/widgets/history.dart';
import 'package:pet_adoption_app/src/home/bloc/event.dart';
import 'package:pet_adoption_app/utils/widgets/bottom_loader.dart';
import 'package:pet_adoption_app/model/pet_model.dart';
import 'package:pet_adoption_app/repo/repo.dart';
export 'package:pet_adoption_app/src/home/bloc/event.dart';

/// Bloc For Home Page with HomeStae & HomeEvent
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  /// Search Note to listen to text
  TextEditingController searchTextController = TextEditingController();
  FocusNode searchTextFocusNode = FocusNode();
  late PetRepo repo;
  int limit = 10;

  HomeBloc([PetRepo? repo]) : super(LoadingState()) {
    /// lisening to events
    on<HomeEvent>(onEventMapping);

    /// Intalizing Reop
    this.repo = repo ?? PetRepo();

    /// Calling to load data
    add(HomeSearchEvent());
  }
  List<PetModel> datas = [];

  Future onEventMapping(HomeEvent event, Emitter<HomeState> emit) async {
    if (event is HomeSearchEvent) {
      // emit(LoadingState());
      datas.clear();
      datas = await getData(event.searchTxt);
      emit(datas.isEmpty ? NoDataState() : DataLoadedState(datas: datas));
    } else if (event is LoadMoreEvemt) {
      if (isLoading) return;
      isLoading = true;
      // emit(LoadingState());
      final dd = await getData(searchTextController.text);
      isDone = dd.length < limit;
      datas.addAll(dd);
      emit(datas.isEmpty
          ? NoDataState()
          : DataLoadedState(id: datas.length.toString(), datas: [...datas]));
      Future.delayed(const Duration(seconds: 1), () {
        isLoading = false;
      });
    }
  }

  bool isDone = false;

  ///  Getting data from repo
  Future<List<PetModel>> getData(String searchtxt) async {
    return repo.getPetData(
        searchTxt: searchtxt, limit: limit, offset: datas.length);
  }

  /// On Tap Pet Details
  void onTapDetails(String id, BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Details(id: id)),
    );
  }

  /// go to History Page
  void onTapHistory(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const History()),
    );
  }

  bool isLoading = false;
  Future<LoaderState> onLoadVisible() async {
    await Future.delayed(const Duration(seconds: 1));
    if (isDone) return LoaderState.noMoreData;
    if (isLoading) return LoaderState.loading;
    add(LoadMoreEvemt());
    return LoaderState.loading;
  }
}
