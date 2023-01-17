import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:goto_app/src/bloc/state.dart';
import 'package:goto_app/src/model/data_model.dart';
import 'package:goto_app/src/service/api_service.dart';
import 'package:goto_app/src/service/local_storage.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class RepoCubit extends Cubit<RepoState> {
  RepoCubit() : super(RepoLoading()) {
    Future.delayed(const Duration(milliseconds: 100), () {
      fetchData();
    });
    networkListner();
  }
  List<RepoDataM> datas = [];
  SortBy lSortBy = SortBy.name;
  Future fetchData([SortBy? sortBy]) async {
    if (sortBy != null) lSortBy = sortBy;
    try {
      emit(RepoLoading());
      datas = await GitApiService.retriveApiData(lSortBy);
      await LocalDb.instance.saveGithubRepo(datas);
      emit(RepoOnData(datas));
    } catch (e) {
      String error = e.toString();
      if (error.contains('host lookup')) {
        error = '';
      }
      emit(RepoErrorPg(error: error));
    }
  }

  void networkListner() {
    final inst = InternetConnectionChecker.createInstance(
        addresses: InternetConnectionChecker.DEFAULT_ADDRESSES,
        checkInterval: const Duration(seconds: 1),
        checkTimeout: const Duration(seconds: 1));
    inst.onStatusChange.listen((result) async {
      if (result == InternetConnectionStatus.disconnected) {
        // emit(RepoErrorPg(error: 'No Internet Connection'));
      } else {
        // fetchData();
      }
    });
  }

  ScrollController scrollController = ScrollController();
}
