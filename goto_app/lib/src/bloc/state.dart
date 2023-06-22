import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import 'package:goto_app/src/model/data_model.dart';

@immutable
abstract class RepoState extends Equatable {
  @override
  List<RepoDataM> get props => [];
}

class RepoLoading extends RepoState {}

class RepoOnData extends RepoState {
  RepoOnData(this.data);
  final List<RepoDataM> data;
  @override
  List<RepoDataM> get props => [...data];

  @override
  String toString() => 'ReponewData(users: ${data.length})';
}

class RepoErrorPg extends RepoState {
  final dynamic error;
  RepoErrorPg({required this.error});
}
