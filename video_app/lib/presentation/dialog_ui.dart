import 'package:flutter/material.dart';
import 'package:video_app/bloc/events.dart';
import 'package:video_app/bloc/home_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Dialog UI
class DialogContent extends StatelessWidget {
  /// Dialog Content
  final ShowDialogState state;
  const DialogContent({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
            padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(.4),
              borderRadius: BorderRadius.circular(5),
            ),
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  state.title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w700),
                ),
                Wrap(
                    spacing: 8,
                    alignment: WrapAlignment.center,
                    children: (state.models.isEmpty
                            ? [context.read<HomeBloc>().initialData!]
                            : state.models)
                        .map(
                      (e) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                            onPressed: () {
                              context.read<HomeBloc>().add(LoadData(data: e));
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 12),
                              child: Text(e.name),
                            ),
                          ),
                        );
                      },
                    ).toList()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
