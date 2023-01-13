import 'package:deriv_bloc/deriv_bloc.dart';
import 'package:deriv_model/models/model.dart';
import 'package:flutter/material.dart';

abstract class HomeEvent extends BaseEvent {}

class LoadingEvent extends HomeEvent {}

class LoadedEvent extends HomeEvent {
  final bool append = true;
  final List<ActiveSymbols> symbols;
  LoadedEvent(this.symbols);
}

class ErrorLoadEvent extends HomeEvent {
  final String onMessage;
  final dynamic error;
  ErrorLoadEvent(this.onMessage, {required this.error});
}

class SelectMarketEvent extends HomeEvent {
  String market;
  SelectMarketEvent({
    required this.market,
  });
}

class SelectSymbolEvent extends HomeEvent {
  String symbol;
  SelectSymbolEvent({
    required this.symbol,
  });
}

class NewTickEvent extends HomeEvent {
  Tick tick;
  NewTickEvent({
    required this.tick,
  });
}

abstract class PriceEvent extends BaseEvent {
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
