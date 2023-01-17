// ignore_for_file: must_be_immutable

import 'package:deriv_bloc/deriv_bloc.dart';
import 'package:deriv_model/models/model.dart';
import 'package:flutter/material.dart';

class LoadingEvent extends HomeState {}

class LoadedEvent extends HomeState {
  final bool append = true;
  final List<ActiveSymbols> symbols;
  LoadedEvent(this.symbols);
}

class ErrorLoadEvent extends HomeState {
  final String onMessage;
  final dynamic error;
  ErrorLoadEvent(this.onMessage, {required this.error});
}

class SelectMarketEvent extends HomeState {
  String market;
  SelectMarketEvent({
    required this.market,
  });
}

class SelectSymbolEvent extends HomeState {
  String symbol;
  SelectSymbolEvent({
    required this.symbol,
  });
}

class NewTickEvent extends HomeState {
  Tick tick;
  NewTickEvent({
    required this.tick,
  });
}

abstract class PriceEvent {
  double get price;
}

class LoadingPrice extends PriceEvent {
  @override
  double get price => throw UnimplementedError();
}

class PriceLoaded extends PriceEvent {
  final double priceValue;
  final Color textColor;
  PriceLoaded({required this.priceValue, required this.textColor});
  @override
  double get price => priceValue;
}

class NoPriceData extends PriceEvent {
  @override
  double get price => throw UnimplementedError();
}

class ErrorOnPriceListen extends PriceEvent {
  String message;
  dynamic error;
  dynamic stk;
  ErrorOnPriceListen(this.error, this.stk, this.message);
  @override
  double get price => throw UnimplementedError();
}
