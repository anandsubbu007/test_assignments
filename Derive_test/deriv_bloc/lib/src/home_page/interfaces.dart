import 'package:deriv_bloc/src/home_page/events.dart';
import 'package:flutter/material.dart';

abstract class HomePageAction {
  /// On Select Symbol
  onSelectSymbol(String? market);
  onSelectMarket(String market);
  List<String> get markets;
  List<String> get symbols;
  double? price;
  Color textColor = Colors.grey;
  Stream<String> get marketStream;
  Stream<String?> get symbolStream;

  /// Provide Price Data
  Stream<PriceEvent> get priceEvents;
}
