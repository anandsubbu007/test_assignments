import 'dart:async';
import 'package:deriv_bloc/deriv_bloc.dart';

import 'package:deriv_data/deriv_data.dart';
import 'package:deriv_model/models/model.dart';
import 'package:deriv_test/dependencies.dart';
import 'package:deriv_test/di/module.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class HomeViewModel extends BasePageViewModel<HomeEvent, HomeState>
    implements HomePageAction {
  List<ActiveSymbols> datas = [];

  /// Market Data Stream. Will Provide String
  StreamController<String> selectedMarket =
      StreamController<String>.broadcast();
  StreamController<String?> selectedSymbol =
      StreamController<String?>.broadcast();
  StreamController<PriceEvent> priceEvent =
      StreamController<PriceEvent>.broadcast();

  HomeEvent? _curEvent;
  late final SocketPort adapter;

  HomeViewModel() : super(LoadingState()) {
    adapter = getIt.get<SocketPort>();
    adapter.sendMessage(SocketService.dataInit);
    adapter.listenToSocket();
    on<HomeEvent>(mapToEvent);
  }

  Future mapToEvent(HomeEvent event, Emitter<HomeState> emit) async {
    _curEvent = event;
    // print('event: $event');
    if (event is LoadingEvent) {
      emit(LoadingState());
    } else if (event is LoadedEvent) {
      if (!event.append) datas.clear();
      datas.addAll(event.symbols);
      emit(LoadedState(markets, symbols));
    } else if (event is ErrorLoadEvent) {
      emit(ErrorLoadedState(error: event.error));
    } else if (event is SelectMarketEvent) {
      onSelectMarket(event.market);
    } else if (event is SelectSymbolEvent) {
      onSelectSymbol(event.symbol);
    } else if (event is NewTickEvent) {
      onNewTicket(event.tick);
    }
  }

  @override
  String toString() {
    return 'HomeEvent: $_curEvent';
  }

  String get tickTriger => SocketService.tickTriger(_selectedSymbol ?? "");
  String get forgetId => SocketService.forgetId(_listeningId ?? '');

  void reqData() {
    add(LoadingEvent());
    adapter.sendMessage(SocketService.dataInit);
  }

  listenToSocket() {
    adapter.marketsDataStream.listen((data) {
      add(LoadedEvent(data));
    });
    adapter.tickDataStream.listen((ticket) {
      if (_selectedSymbol == ticket.symbol) {
        _listeningId = ticket.id;
        add(NewTickEvent(tick: ticket));
      }
    });
    adapter.errorStream.listen((error) {
      add(ErrorLoadEvent('Socket Error', error: error.toString()));
    });
  }

  ///
  String? _selectedMarket, _selectedSymbol, _listeningId;
  @override
  List<String> get markets => datas.map((e) => e.vName).toSet().toList();
  @override
  List<String> get symbols => datas
      .where((e) => e.vName == (_selectedMarket ?? '--1'))
      .map((e) => e.vSymbol)
      .toSet()
      .toList();
  @override
  double? price;
  @override
  Color textColor = Colors.grey;

  @override
  onSelectMarket(String market) {
    _selectedMarket = market;
    selectedMarket.add(market);
    onSelectSymbol(null);
    resetPrice();
  }

  @override
  onSelectSymbol(String? market) {
    // if (_selectedSymbol != null) {}
    _selectedSymbol = market;
    selectedSymbol.add(market);
    if (market != null) {
      resetPrice();
      priceEvent.add(LoadingPrice());
      adapter.sendMessage(tickTriger);
    }
  }

  void resetPrice() {
    price = null;
    textColor = Colors.grey;
    if (_listeningId != null) {
      priceEvent.add(NoPriceData());
      adapter.sendMessage(forgetId);
    }
  }

  onNewTicket(Tick tick) {
    final newVal = tick.quote;
    if (newVal == price) return;
    if (price == null) {
      textColor = Colors.grey;
    } else if (newVal > price!) {
      textColor = Colors.green;
    } else if (newVal < price!) {
      textColor = Colors.red;
    }
    price = newVal;
    priceEvent.add(PriceLoaded(priceValue: newVal, textColor: textColor));
  }

  @override
  Stream<String> get marketStream => selectedMarket.stream;

  @override
  Stream<PriceEvent> get priceEvents => priceEvent.stream;

  @override
  Stream<String?> get symbolStream => selectedSymbol.stream;
}
