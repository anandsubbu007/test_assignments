import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glassmorphism_ui/glassmorphism_ui.dart';
import 'package:pet_adoption_app/src/details/bloc/details_bloc.dart';
import 'package:pet_adoption_app/model/pet_model.dart';
import 'package:pet_adoption_app/src/details/widgets/adopt_button.dart';
import 'package:pet_adoption_app/utils/widgets/custom_image_viewer.dart';
import 'package:pet_adoption_app/utils/widgets/ratings_widget.dart';
import 'package:shimmer/shimmer.dart';

/// Details page
class Details extends StatelessWidget {
  final String id;
  const Details({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    /// adding bloc to page
    return BlocProvider.value(
        value: DetailsBloc(id: id),
        child: const DetailsBody(
          key: Key('DetailPg'),
        ));
  }
}

///
class DetailsBody extends StatefulWidget {
  const DetailsBody({Key? key}) : super(key: key);

  @override
  State<DetailsBody> createState() => _DetailsState();
}

class _DetailsState extends State<DetailsBody> {
  late DetailsBloc bloc;
  late String id;
  @override
  void didChangeDependencies() {
    /// Inititing
    bloc = context.read<DetailsBloc>();
    // bloc.add(LoadData());
    id = bloc.id;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
        bloc: bloc,
        listener: (_, __) {},
        builder: (context, state) {
          bool isLoading = state is LoadingState;

          /// Listening to State
          if (state is Loaded || isLoading) {
            final pet = state is Loaded ? state.data : null;
            return Scaffold(
              backgroundColor: Theme.of(context).primaryColor,
              extendBodyBehindAppBar: true,
              body: Stack(
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        DetailHeader(id: id, pet: pet),
                        const SizedBox(height: 16),
                        if (pet != null) _petAttributes(pet),
                        if (pet != null) PetDetails(pet: pet),
                        _confettiWidget(),
                      ],
                    ),
                  ),
                  const Align(
                      alignment: Alignment.topCenter,
                      widthFactor: double.infinity,
                      child: DetailAppBar())
                ],
              ),
              bottomSheet: pet == null ? const SizedBox() : const AdoptButton(),
            );
          } else {
            return const Scaffold(
                body: Center(child: Text("State Not Handled")));
          }
        });
  }

  /// pet attributes
  Widget _petAttributes(PetModel pet) {
    return SizedBox(
      height: 100,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(child: _boxAttributeContainer('Sex', pet.sex)),
          Expanded(child: _boxAttributeContainer('Color', pet.color)),
          Expanded(child: _boxAttributeContainer('Age', pet.age)),
        ],
      ),
    );
  }

  Widget _boxAttributeContainer(String title, String value) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: const BorderRadius.all(Radius.circular(16))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          FittedBox(
            fit: BoxFit.contain,
            child: Text(
              title,
              style: Theme.of(context).textTheme.labelMedium,
            ),
          ),
          FittedBox(
            fit: BoxFit.contain,
            child: Text(
              value,
              style: Theme.of(context).textTheme.titleSmall,
            ),
          )
        ],
      ),
    );
  }

  /// confitee widget to show animation
  Widget _confettiWidget() {
    return Padding(
      padding: const EdgeInsets.only(left: 40, right: 40),
      child: Row(
        children: [
          ConfettiWidget(
            confettiController: bloc.confettiController,
            blastDirection: -pi / 3,
            gravity: 0.1,
            numberOfParticles: 25,
            emissionFrequency: 0.1,
          ),
          const Spacer(),
          ConfettiWidget(
            confettiController: bloc.confettiController,
            blastDirection: 720 / 180,
            gravity: 0.1,
            numberOfParticles: 25,
            emissionFrequency: 0.1,
          ),
        ],
      ),
    );
  }
}

/// App Bar
class DetailAppBar extends StatelessWidget {
  const DetailAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          IconButton.filled(key: const Key("pop_detail"),
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back))
        ],
      ),
    );
  }
}

/// Image & Nage of pet
class DetailHeader extends StatelessWidget {
  final String id;
  final PetModel? pet;
  const DetailHeader({super.key, required this.id, this.pet});

  @override
  Widget build(BuildContext context) {
    Widget placeHolder() => Shimmer.fromColors(
          baseColor: Colors.black26,
          highlightColor: Colors.black12,
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: Colors.black54),
            width: double.infinity,
            height: 350,
          ),
        );
    final theme = Theme.of(context);
    return Stack(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: 350,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.vertical(
                top: Radius.circular(40), bottom: Radius.zero),
          ),
          child: Hero(
            tag: id,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CustomImageViewer(
                        imageUrl: pet!.image, heroId: pet!.id),
                  ),
                );
              },
              child: pet == null
                  ? placeHolder()
                  : CachedNetworkImage(
                      imageUrl: pet!.image,
                      placeholder: (context, url) => placeHolder(),
                      imageBuilder: (context, imageProvider) => Container(
                        decoration: BoxDecoration(
                          // borderRadius: BorderRadius.circular(40),
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          child: GlassContainer(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
            ),
            blur: 10,
            opacity: 0.30,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 90,
              padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black87.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 1,
                    offset: const Offset(0, 2), // changes position of shadow
                  ),
                ],
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(pet?.name ?? '',
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: theme.primaryColor)),
                      const SizedBox(height: 8),
                      RatingWidget(value: pet?.rate ?? 1)
                    ],
                  ),
                  const Spacer(),
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 9, vertical: 4),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border:
                              Border.all(color: theme.primaryColor, width: 2)),
                      child: Text(pet?.price ?? "",
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(
                                  fontWeight: FontWeight.w500,
                                  color: theme.primaryColor)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class PetDetails extends StatelessWidget {
  final PetModel pet;
  const PetDetails({super.key, required this.pet});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 80),
      child: Text(
        pet.description,
        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
      ),
    );
  }
}
