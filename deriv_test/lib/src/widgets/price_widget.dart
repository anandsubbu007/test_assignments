import 'package:deriv_bloc/deriv_bloc.dart';
import 'package:flutter/material.dart';

class Pricing extends StatelessWidget {
  final HomePageAction model;
  const Pricing({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: StreamBuilder<PriceEvent>(
            stream: model.priceEvents,
            initialData: NoPriceData(),
            builder: (context, snapshot) {
              final state = snapshot.data;
              if (state is LoadingPrice) {
                return const CircularProgressIndicator();
              } else if (state is NoPriceData) {
                return const SizedBox();
              } else if (state is PriceLoaded) {
                return PriceWidget(key: const Key('Price'), state: state);
              }
              return const SizedBox();
            }));
  }
}

class PriceWidget extends StatelessWidget {
  final PriceLoaded state;
  const PriceWidget({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(6),
      child: Text(
        'Price: ${state.price}',
        style: Theme.of(context)
            .textTheme
            .titleLarge
            ?.copyWith(color: state.textColor),
      ),
    );
  }
}
