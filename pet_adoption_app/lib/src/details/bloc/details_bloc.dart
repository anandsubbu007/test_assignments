// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_adoption_app/model/pet_model.dart';
import 'package:pet_adoption_app/provider/adoption.dart';
import 'package:pet_adoption_app/repo/repo.dart';
import 'package:pet_adoption_app/src/details/bloc/events.dart';
import 'package:pet_adoption_app/src/details/widgets/adopted_popup.dart';
import 'package:pet_adoption_app/utils/theme/theme.dart';
export 'package:pet_adoption_app/src/details/bloc/events.dart';

/// detaisl of pet Blco
class DetailsBloc extends Bloc<DetailEvent, DetailState> {
  /// Adoption data
  bool isAdopted = true;

  /// confitte controller to show confitee
  ConfettiController confettiController =
      ConfettiController(duration: const Duration(seconds: 1));

  bool isPlayConfetti = false;
  late PetRepo repo;
  final String id;
  DetailsBloc({required this.id, PetRepo? repo}) : super(LoadingState()) {
    this.repo = repo ?? PetRepo();
    on<DetailEvent>(onEventMapping);
    add(LoadData());
  }

  /// loaded Pet data
  late PetModel _pet;

  /// Listening to event
  void onEventMapping(DetailEvent event, Emitter<DetailState> emit) async {
    if (event is LoadData) {
      _pet = await repo.getById(id);
      emit(Loaded(data: _pet));
    }
  }

  /// on Tap Adopted
  void onClickAdoptMe(BuildContext context) async {
    isAdopted = !isAdopted;
    if (isPlayConfetti) {
      confettiController.stop();
    } else {
      confettiController.play();
    }
    isPlayConfetti = !isPlayConfetti;

    /// Updating data in cache
    final isItDone =
        await Provider.of<AdoptionProvider>(context, listen: false).adopt(id);
    if (isItDone && context.mounted) {
      /// showing adopted info
      showDialog(
          context: context,
          builder: (context) {
            return AdoptedDialog(
                pet: _pet, confettiController: confettiController);
          });
    }
  }
}
