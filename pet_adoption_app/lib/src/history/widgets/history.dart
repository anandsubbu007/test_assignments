import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_adoption_app/src/details/widgets/app_bar.dart';
import 'package:pet_adoption_app/src/history/bloc/history_bloc.dart';
import 'package:pet_adoption_app/src/home/bloc/home_bloc.dart';
import 'package:pet_adoption_app/src/home/widgets/pet_widget.dart';
import 'package:pet_adoption_app/model/pet_model.dart';

/// Hisory Page
class History extends StatefulWidget {
  const History({Key? key}) : super(key: key);

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  late HistoryBloc bloc;
  @override
  Widget build(BuildContext context) {
    bloc = HistoryBloc(context);
    return BlocConsumer(
        bloc: bloc,
        listener: (c, s) {},
        builder: (context, state) {
          /// Handlindg States
          final isLoading = state is LoadingState;
          final datas = state is DataLoadedState ? state.datas : <PetModel>[];
          return Scaffold(
            backgroundColor: Theme.of(context).primaryColor,
            appBar:
                const MyAppBar(title: "Adopted Pets", showClearButton: true),
            body: SafeArea(
                child: isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : _petListWidget(datas)),
          );
        });
  }

  Widget _petListWidget(List<PetModel> pets) {
    return pets.isNotEmpty
        ? ListView.builder(
            shrinkWrap: true,
            itemBuilder: (context, index) => PetWidget(
              pet: pets[index],
              onTap: () {
                bloc.onTapDetails(pets[index].id, context);
              },
            ),
            itemCount: pets.length,
          )
        : const Center(
            child: Text('No pets adopted.'),
          );
  }
}
