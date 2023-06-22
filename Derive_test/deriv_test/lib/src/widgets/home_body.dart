import 'package:deriv_bloc/deriv_bloc.dart';
import 'package:deriv_test/src/widgets/dropdown.dart';
import 'package:deriv_test/src/widgets/price_widget.dart';
import 'package:flutter/material.dart';

class LoadedBody extends StatefulWidget {
  final HomePageAction model;
  const LoadedBody({super.key, required this.model});

  @override
  State<LoadedBody> createState() => _LoadedBodyState();
}

class _LoadedBodyState extends State<LoadedBody> {
  late final Stream<String> selectedMarket;
  late final Stream<String?> selectedSymbol;
  @override
  void initState() {
    selectedMarket = widget.model.marketStream;
    selectedSymbol = widget.model.symbolStream;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(18, 15, 18, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          StreamBuilder<String>(
              stream: selectedMarket,
              builder: (context, snapshot) {
                final data = snapshot.data;
                return AppDropDown<String>(
                    titles: 'Market',
                    items: widget.model.markets
                        .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                        .toList(),
                    selected: data,
                    onChange: (d) async {
                      // widget.model.add(SelectMarketEvent(market: d!));
                      widget.model.onSelectMarket(d!);
                      return true;
                    });
              }),
          StreamBuilder<String?>(
              stream: selectedSymbol,
              builder: (context, snapshot) {
                final data = snapshot.data;
                return AppDropDown(
                    titles: 'Symbol',
                    items: widget.model.symbols
                        .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                        .toList(),
                    selected: data,
                    onChange: (d) async {
                      // widget.model.add(SelectSymbolEvent(symbol: d!));
                      widget.model.onSelectSymbol(d!);
                      return true;
                    });
              }),
          Expanded(child: Pricing(model: widget.model)),
        ],
      ),
    );
  }
}
