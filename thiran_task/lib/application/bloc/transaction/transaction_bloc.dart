import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thiran_task/domain/di/app_preferences.dart';

import '../../../infrastructure/db/database_utils.dart';
import '../../../domain/model/error_response.dart';
import '../../../domain/model/transaction_model.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  TransactionBloc(TransactionInitial transactionInitial)
      : super(transactionInitial) {
    on<OnSaveEvent>((event, emit) async {
      dynamic response = await DBProvider.db.newTransaction(event.transaction);
      if (response is int) {
        emit(TransactionSaved());
      } else {
        emit(TransactionError(response));
      }
    });
    on<OnFormLoadEvent>((event, emit) async {
      emit(NewTransForm());
    });
  }

  Future<List<TransactionM>> get getTransactions =>
      DBProvider.db.getAllTransaction();

  bool get canIShowReport {
    return DateTime.now()
            .difference(AppPreferences.instance.lastMailPushTime)
            .inDays
            .abs() >
        1;
  }
}

/// Transaction States

abstract class TransactionState extends Equatable {
  const TransactionState();

  @override
  List<Object?> get props => [];
}

class TransactionInitial extends TransactionState {}

class TransactionLoading extends TransactionState {}

class TextTransactionLoaded extends TransactionState {
  const TextTransactionLoaded();
}

class TransactionError extends TransactionState {
  final ErrorResponse error;

  const TransactionError(this.error);
}

class TransactionSaved extends TransactionState {}

class NewTransForm extends TransactionState {}

///Transaction Events
///
abstract class TransactionEvent {}

class PageOnLoadEvent extends TransactionEvent {
  PageOnLoadEvent();
}

class OnFormLoadEvent extends TransactionEvent {
  OnFormLoadEvent();
}

class OnSaveEvent extends TransactionEvent {
  TransactionM transaction;

  OnSaveEvent({required this.transaction});
}

class OnTransactionLoadEvent extends TransactionEvent {}
