import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thiran_task/infrastructure/api/firebase_utils.dart';

import '../../../domain/model/firebase_request.dart';

/// Firebase Listing controller Bloc
class FirebaseListBloc extends Bloc<FirebaseListEvent, FirebaseListState> {
  FirebaseListBloc(FirebaseListInitial transactionInitial)
      : super(transactionInitial) {
    on<PageOnLoadEvent>((event, emit) async {
      emit(FirebaseListLoading());
    });
    on<OnFetchFirebaseEvent>((event, emit) async {
      dynamic response = await FirebaseUtils.getBugReport();
      if (response is List<FirebaseRequest>) {
        emit(FirebaseListLoaded([...response]));
      } else {
        emit(FirebaseListError(response));
      }
    });
  }
}

/// FirebaseList States

abstract class FirebaseListState {
  const FirebaseListState();
}

class FirebaseListInitial extends FirebaseListState {}

class FirebaseListLoading extends FirebaseListState {}

// ignore: must_be_immutable
class FirebaseListLoaded extends FirebaseListState {
  List<FirebaseRequest> firebaseList;

  FirebaseListLoaded(this.firebaseList);

  @override
  String toString() => 'FirebaseListLoaded(firebaseList: $firebaseList)';
}

class FirebaseListError extends FirebaseListState {
  final dynamic error;

  const FirebaseListError(this.error);
}

///FirebaseList Events
///
abstract class FirebaseListEvent {}

class PageOnLoadEvent extends FirebaseListEvent {
  PageOnLoadEvent();
}

class OnFetchFirebaseEvent extends FirebaseListEvent {
  OnFetchFirebaseEvent();
}

class OnFirebaseListLoadEvent extends FirebaseListEvent {}
