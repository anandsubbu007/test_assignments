import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:thiran_task/infrastructure/repo/github_repository.dart';
import 'package:thiran_task/domain/model/github_response.dart';
import 'package:thiran_task/domain/di/app_preferences.dart';

import '../../../domain/model/error_response.dart';

class GithubBloc extends Bloc<GithubEvent, GithubState> {
  final GithubRepository _repository = GithubRepository();
  GithubResponse githubResponse = GithubResponse();

  GithubBloc(GithubInitial transactionInitial) : super(transactionInitial) {
    on<PageOnLoadEvent>((event, emit) async {
      dynamic response = await _repository.getGithubRepository(
          url:
              "https://api.github.com/search/repositories?q=created:%3E${getDate()}&sort=stars&order=desc");
      if (response is GithubResponse) {
        githubResponse = response;
        emit(GithubLoaded(githubResponse));
      } else {
        emit(GithubError(response));
      }
    });
    on<OnGithubListPaginationEvent>((event, emit) async {
      if (!(AppPreferences.instance.isLastPage)) {
        dynamic response = await _repository.getGithubRepository(
            url: AppPreferences.instance.nextPageUrl!);
        if (response is GithubResponse) {
          githubResponse.items!.addAll(response.items!);
          emit(GithubLoaded(githubResponse));
        } else {
          emit(GithubError(response));
        }
      } else {
        debugPrint("All Pages Loaded");
      }
    });
    on<OnGithubPaginationLoadEvent>((event, emit) async {
      emit(GithubLoading());
    });
  }
}

String getDate() {
  return DateFormat("yyyy-MM-dd")
      .format(DateTime.now().subtract(const Duration(days: 30)));
}

/// Github States

abstract class GithubState extends Equatable {
  const GithubState();

  @override
  List<Object?> get props => [];
}

class GithubInitial extends GithubState {}

class GithubLoading extends GithubState {}

class GithubLoaded extends GithubState {
  final GithubResponse response;

  const GithubLoaded(this.response);
}

class GithubAllPagesLoaded extends GithubState {
  final GithubResponse response;

  const GithubAllPagesLoaded(this.response);
}

class TextGithubLoaded extends GithubState {
  const TextGithubLoaded();
}

class GithubError extends GithubState {
  final ErrorResponse error;

  const GithubError(this.error);
}

///Github Events
///
abstract class GithubEvent {}

class PageOnLoadEvent extends GithubEvent {
  PageOnLoadEvent();
}

class OnGithubListPaginationEvent extends GithubEvent {
  String value;

  OnGithubListPaginationEvent({this.value = ""});
}

class OnGithubPaginationLoadEvent extends GithubEvent {}
