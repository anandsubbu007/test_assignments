import 'dart:async';

import 'package:deriv_bloc/deriv_bloc.dart';
import 'package:deriv_data/deriv_data.dart';
import 'package:deriv_model/models/model.dart';
import 'package:deriv_test/dependencies.dart';
import 'package:deriv_test/di/module.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateNiceMocks([MockSpec<HomePageCubit>()])
@injectable
class HomePageCubit extends BasePageViewModel<HomeState>
    implements HomePageAction {
  List<ActiveSymbols> datas = [];

  /// Market Data Stream. Will Provide String
  StreamController<String> selectedMarket =
      StreamController<String>.broadcast();
  StreamController<String?> selectedSymbol =
      StreamController<String?>.broadcast();
  StreamController<PriceEvent> priceEvent =
      StreamController<PriceEvent>.broadcast();

  late final SocketPort adapter;

  HomePageCubit() : super(LoadingState()) {
    adapter = getIt.get<SocketPort>();
    adapter.sendMessage(SocketService.dataInit);
    adapter.listenToSocket();
    // on<HomeEvent>(mapToEvent);
  }

  Future mapToEvent(HomeState state) async {
    if (state is LoadingEvent) {
      emit(LoadingState());
    } else if (state is LoadedEvent) {
      if (!state.append) datas.clear();
      datas.addAll(state.symbols);
      emit(LoadedState(markets, symbols));
    } else if (state is ErrorLoadEvent) {
      emit(ErrorLoadedState(error: state.error));
    } else if (state is SelectMarketEvent) {
      onSelectMarket(state.market);
    } else if (state is SelectSymbolEvent) {
      onSelectSymbol(state.symbol);
    } else if (state is NewTickEvent) {
      onNewTicket(state.tick);
    }
  }

  String get tickTriger => SocketService.tickTriger(_selectedSymbol ?? "");
  String get forgetId => SocketService.forgetId(_listeningId ?? '');

  void reqData() {
    mapToEvent(LoadingEvent());
    adapter.sendMessage(SocketService.dataInit);
  }

  listenToSocket() {
    adapter.marketsDataStream.listen((data) {
      mapToEvent(LoadedEvent(data));
    });
    adapter.tickDataStream.listen((ticket) {
      // print('==> $_selectedSymbol');
      if (_selectedSymbol == ticket.symbol) {
        _listeningId = ticket.id;
        mapToEvent(NewTickEvent(tick: ticket));
      }
    });
    adapter.errorStream.listen((error) {
      mapToEvent(ErrorLoadEvent('Socket Error', error: error.toString()));
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
