import 'package:flutter/material.dart';
import 'package:goto_app/generated/assets.gen.dart';
import 'package:goto_app/src/bloc/cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../utils/context_ext.dart';

class ErrorBody extends StatelessWidget {
  final dynamic error;
  const ErrorBody({super.key, this.error});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.shade50,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
              child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 10, 8),
                    child: Assets.illustration.nointernetConnection.image(),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Something went wrong..',
                  textAlign: TextAlign.center,
                  style: context.textThem.titleLarge,
                ),
                const SizedBox(height: 8),
                Text(
                  'An Alien is probably blocking your signal.',
                  style: context.textThem.labelLarge
                      ?.copyWith(color: Colors.black54),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                Text(error.toString(),
                    style: context.textThem.bodySmall
                        ?.copyWith(color: Colors.black54),
                    textAlign: TextAlign.center),
                const SizedBox(height: 20),
              ],
            ),
          )),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 15),
            child: Material(
              child: InkWell(
                onTap: () {
                  context.read<RepoCubit>().fetchData();
                },
                child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                      color: Colors.transparent,
                      border: Border.all(color: Colors.green, width: 1.5),
                      borderRadius: BorderRadius.circular(4)),
                  child: Center(
                      child: Text(
                    'RETRY',
                    style: context.textThem.labelLarge
                        ?.copyWith(color: Colors.green),
                  )),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
