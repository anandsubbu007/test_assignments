import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ap/model/game_model.dart';
import 'package:flutter_ap/presentation/details/bloc/details_bloc.dart';
import 'package:flutter_ap/utils/widgets/ratings_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glassmorphism_ui/glassmorphism_ui.dart';
import 'package:shimmer/shimmer.dart';

/// Details page
class Details extends StatelessWidget {
  final int id;
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
  late int id;
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
            final data = state is Loaded ? state.data : null;
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
                        DetailHeader(id: id, data: data),
                        const SizedBox(height: 16),
                        if (data != null) _gameAttributes(data),
                        if (data != null) GameDetails(game: data),
                      ],
                    ),
                  ),
                  const Align(
                      alignment: Alignment.topCenter,
                      widthFactor: double.infinity,
                      child: DetailAppBar())
                ],
              ),
            );
          } else {
            return const Scaffold(
                body: Center(child: Text("State Not Handled")));
          }
        });
  }

  /// game attributes
  Widget _gameAttributes(GamesModel game) {
    return SizedBox(
      height: 100,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
              child: _boxAttributeContainer('Released', game.released ?? '')),
          // Expanded(child: _boxAttributeContainer('Color', game.added ?? '')),
          // Expanded(child: _boxAttributeContainer('Age', game.age)),
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
          IconButton.filled(
              key: const Key("pop_detail"),
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back))
        ],
      ),
    );
  }
}

/// Image & Nage of game
class DetailHeader extends StatelessWidget {
  final int id;
  final GamesModel? data;
  const DetailHeader({super.key, required this.id, required this.data});

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
              onTap: () {},
              child: data?.backgroundImage == null
                  ? placeHolder()
                  : CachedNetworkImage(
                      imageUrl: data!.backgroundImage!,
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
                      Text(data?.name ?? '',
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: theme.primaryColor)),
                      const SizedBox(height: 8),
                      RatingWidget(value: data?.rating ?? 1)
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
                      child: Text(data?.playtime?.toString() ?? "",
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

class GameDetails extends StatelessWidget {
  final GamesModel game;
  const GameDetails({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 80),
      child: Text(
        game.description ?? '',
        style: const TextStyle(
            fontSize: 14, color: Colors.white, fontWeight: FontWeight.w600),
      ),
    );
  }
}
