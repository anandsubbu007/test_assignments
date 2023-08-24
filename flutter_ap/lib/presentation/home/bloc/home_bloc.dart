// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:flutter_ap/infrastructure/repo/game_repo.dart';
import 'package:flutter_ap/model/game_model.dart';
import 'package:flutter_ap/presentation/details/details_pg.dart';
import 'package:flutter_ap/presentation/home/bloc/event.dart';
import 'package:flutter_ap/utils/widgets/bottom_loader.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

export 'package:flutter_ap/presentation/home/bloc/event.dart';

/// Bloc For Home Page with HomeStae & HomeEvent
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  /// Search Note to listen to text
  TextEditingController searchTextController = TextEditingController();
  FocusNode searchTextFocusNode = FocusNode();
  late GameRepo repo;
  int page = 1;

  HomeBloc([GameRepo? repo]) : super(LoadingState()) {
    /// lisening to events
    on<HomeEvent>(onEventMapping);

    /// Intalizing Reop
    this.repo = repo ?? GameRepo();

    /// Calling to load data
    add(HomeSearchEvent());
  }
  List<GamesModel> datas = [];
  List<int> lstGenFiltered = [], lastPlatformFiltered = [];
  Future onEventMapping(HomeEvent event, Emitter<HomeState> emit) async {
    if (event is HomeSearchEvent) {
      emit(LoadingState());
      Future.delayed(const Duration(seconds: 1));
      datas.clear();
      // if (event.geners.isNotEmpty)
      lstGenFiltered = event.geners;
      // if (event.platform.isNotEmpty)
      lastPlatformFiltered = event.platform;
      try {
        datas = await getData(event.searchTxt);
        final state = datas.isEmpty
            ? NoDataState()
            : DataLoadedState(datas: [...datas], id: UniqueKey().toString());
        emit(state);
      } catch (e) {
        emit(ErrorState(e.toString()));
      }
    } else if (event is LoadMoreEvent) {
      if (isLoading) return;
      isLoading = true;
      page += 1;
      // emit(LoadingState());
      try {
        final dd = await getData(searchTextController.text);
        datas.addAll(dd);
        emit(datas.isEmpty
            ? NoDataState()
            : DataLoadedState(id: datas.length.toString(), datas: [...datas]));
      } catch (e) {
        emit(ErrorState(e.toString()));
      }
      Future.delayed(const Duration(seconds: 1), () {
        isLoading = false;
      });
    }
  }

  bool isDone = false;

  ///  Getting data from repo
  Future<List<GamesModel>> getData(
    String searchtxt,
  ) async {
    return repo.getData(
        searchTxt: searchtxt,
        generes: lstGenFiltered,
        platofrms: lastPlatformFiltered,
        page: page);
  }

  /// On Tap Game Details
  void onTapDetails(int id, BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Details(id: id)),
    );
  }

  bool isLoading = false;
  Future<LoaderState> onLoadVisible() async {
    await Future.delayed(const Duration(seconds: 1));
    if (isDone) return LoaderState.noMoreData;
    if (isLoading) return LoaderState.loading;
    add(LoadMoreEvent());
    return LoaderState.loading;
  }
}
