import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class ActiveSymbols extends Equatable {
  int? allowForwardStarting;
  String? displayName;
  int? displayOrder;
  int? exchangeIsOpen;
  int? isTradingSuspended;
  String? market;
  String? marketDisplayName;
  double? pip;
  String? subgroup;
  String? subgroupDisplayName;
  String? submarket;
  String? submarketDisplayName;
  String? symbol;
  String? symbolType;

  ActiveSymbols(
      {this.allowForwardStarting,
      this.displayName,
      this.displayOrder,
      this.exchangeIsOpen,
      this.isTradingSuspended,
      this.market,
      this.marketDisplayName,
      this.pip,
      this.subgroup,
      this.subgroupDisplayName,
      this.submarket,
      this.submarketDisplayName,
      this.symbol,
      this.symbolType});

  ActiveSymbols.fromJson(Map<String, dynamic> json) {
    allowForwardStarting =
        int.tryParse((json['allow_forward_starting'].toString())) ?? 0;
    displayName = json['display_name'];
    displayOrder = int.tryParse((json['display_order'].toString())) ?? 0;
    exchangeIsOpen = int.tryParse((json['exchange_is_open'].toString())) ?? 0;
    isTradingSuspended =
        int.tryParse((json['is_trading_suspended'].toString())) ?? 0;
    market = json['market'];
    marketDisplayName = json['market_display_name'];
    pip = double.tryParse((json['pip'].toString())) ?? 0;
    subgroup = json['subgroup'];
    subgroupDisplayName = json['subgroup_display_name'];
    submarket = json['submarket'];
    submarketDisplayName = json['submarket_display_name'];
    symbol = json['symbol'];
    symbolType = json['symbol_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['allow_forward_starting'] = allowForwardStarting;
    data['display_name'] = displayName;
    data['display_order'] = displayOrder;
    data['exchange_is_open'] = exchangeIsOpen;
    data['is_trading_suspended'] = isTradingSuspended;
    data['market'] = market;
    data['market_display_name'] = marketDisplayName;
    data['pip'] = pip;
    data['subgroup'] = subgroup;
    data['subgroup_display_name'] = subgroupDisplayName;
    data['submarket'] = submarket;
    data['submarket_display_name'] = submarketDisplayName;
    data['symbol'] = symbol;
    data['symbol_type'] = symbolType;
    return data;
  }

  String get vName => marketDisplayName ?? market ?? displayName ?? '';
  String get vSymbol => symbol ?? '';

  @override
  List<Object?> get props => [vName, vSymbol];
}

// ignore: must_be_immutable
class Tick extends Equatable {
  double? ask;
  double? bid;
  int? epoch;
  late String id;
  int? pipSize;
  late double quote;
  String symbol;
  Tick(
      {this.ask,
      this.bid,
      this.epoch,
      required this.id,
      this.pipSize,
      required this.quote,
      required this.symbol});

  // Tick.fromJson(Map<String, dynamic> json) {
  //   ask = double.tryParse((json['ask'].toString())) ?? 0;
  //   bid = double.tryParse((json['bid'].toString())) ?? 0;
  //   epoch = int.tryParse((json['epoch'].toString())) ?? 0;
  //   id = json['id'] ?? '';
  //   pipSize = json['pip_size'];
  //   quote = double.tryParse((json['quote'].toString())) ?? 0;
  //   symbol = json['symbol'];
  // }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ask'] = ask;
    data['bid'] = bid;
    data['epoch'] = epoch;
    data['id'] = id;
    data['pip_size'] = pipSize;
    data['quote'] = quote;
    data['symbol'] = symbol;
    return data;
  }

  @override
  List<Object?> get props => [symbol, id];

  factory Tick.fromMap(Map<String, dynamic> map) {
    return Tick(
      ask: double.tryParse((map['ask'].toString())) ?? 0,
      bid: double.tryParse((map['bid'].toString())) ?? 0,
      epoch: int.tryParse((map['epoch'].toString())) ?? 0,
      id: map['id'],
      pipSize: map['pipSize']?.toInt(),
      quote: map['quote'],
      symbol: map['symbol'] ?? '',
    );
  }
}
