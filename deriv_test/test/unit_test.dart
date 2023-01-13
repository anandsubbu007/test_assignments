import 'dart:math';

import 'package:bloc_test/bloc_test.dart';
import 'package:deriv_bloc/deriv_bloc.dart';
import 'package:deriv_data/deriv_data.dart';
import 'package:deriv_data/src/socket_adapter.mocks.dart';
import 'package:deriv_model/models/model.dart';
import 'package:deriv_test/dependencies.dart';
import 'package:deriv_test/di/module.dart';
import 'package:deriv_test/src/hp_model.dart';
import 'package:deriv_test/src/hp_model.mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

void main() {
  final MockSocketAdapter socket = MockSocketAdapter();
  // final SocketAdapter socket = SocketAdapter();
  getIt.registerSingleton<SocketPort>(socket);
  final HomePageCubit taskCubit = HomePageCubit();

  setUp(() {});
  group('Socket Streams', () {
    when(socket.sendMessage(SocketService.dataInit)).thenAnswer((a) {
      socket.marketsData.add(SampleData.datas);
    });
    when(socket.sendMessage(SocketService.tickTriger(SampleData.testSymbol)))
        .thenAnswer((a) {
      socket.tickData.add(SampleData.getRandomTick);
    });
    test("Market Data", () async* {
      expectLater(socket.marketsDataStream, emitsInOrder(SampleData.tickDatas));
    });
    test("Price of Symbol Stream", () async* {
      expectLater(socket.marketsDataStream, emitsAnyOf(SampleData.tickDatas));
    });
  });
  group("Home Actions", () {
    // test("On Tap Market", () async* {
    //   when(taskCubit.onSelectMarket(SampleData.selectedMarket.vName))
    //       .thenAnswer((a) {});
    //   expectLater(taskCubit.selectedMarket, emits(SampleData.selectedMarket));
    //   expect(taskCubit.price, 1);
    //   expect(taskCubit.selectedSymbol, emits(null));
    // });
    when(socket.sendMessage(SocketService.dataInit)).thenAnswer((a) {
      socket.marketsData.add(SampleData.datas);
    });

    blocTest<HomePageCubit, HomeState>(
      'emits [UserProfile On Tap: SelectionChange] with correct urgent tasks',
      build: () {
        return taskCubit;
      },
      act: (cubit) {
        cubit.reqData();
      },
      expect: () async => [
        LoadingState(),
        expectLater(taskCubit.marketStream,
            emitsInOrder(SampleData.datas.map((e) => e.vName)))
      ],
    );

    // blocTest<MockHomePageCubit, HomeState>(
    //   'emits [UserProfile On Tap: SelectionChange] with correct urgent tasks',
    //   build: () => taskCubit,
    //   act: (cubit) {
    //     cubit.reqData();
    //     socket.marketsData.add(SampleData.datas);
    //   },
    //   expect: () => [
    //     LoadingEvent(),
    //     LoadedState(SampleData.datas.map((e) => e.vName).toList(), []),
    //   ],
    // );
  });
  // selectedMarket
}

class SampleData {
  static ActiveSymbols symbol =
      ActiveSymbols(marketDisplayName: "TestName", symbol: testSymbol);
  static ActiveSymbols symbol1 =
      ActiveSymbols(marketDisplayName: "TestName", symbol: "b");
  static ActiveSymbols symbol2 =
      ActiveSymbols(marketDisplayName: "TestName 2", symbol: "c");
  static List<ActiveSymbols> datas = [symbol, symbol1, symbol2];
  static String testSymbol = 'A';
  static ActiveSymbols selectedMarket = symbol;
  static List<ActiveSymbols> selectedMatketSymbols = [symbol, symbol1, symbol2];

  static Tick tick1 = Tick(id: "1", quote: 1.2, symbol: testSymbol);
  static Tick tick11 = Tick(id: "1", quote: 1.13, symbol: testSymbol);
  static Tick tick12 = Tick(id: "1", quote: 1.4, symbol: testSymbol);
  static Tick tick2 = Tick(id: "2", quote: 1.2, symbol: "b");
  static Tick tick3 = Tick(id: "3", quote: 1.2, symbol: "c");
  static List<Tick> tickDatas = [tick1, tick11, tick12];
  static Tick get getRandomTick => tickDatas.elementAt(Random().nextInt(3));
}

class MockWebSocketChannel extends WebSocketChannel {
  MockWebSocketChannel(super.channel);


}
