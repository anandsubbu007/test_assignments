import 'package:flutter/material.dart';
import 'package:flutter_ap/model/game_model.dart';
import 'package:flutter_ap/presentation/home/bloc/home_bloc.dart';
import 'package:flutter_ap/presentation/home/widgets/app_bar.dart';
import 'package:flutter_ap/presentation/home/widgets/game_list_tile.dart';
import 'package:flutter_ap/utils/widgets/bottom_loader.dart';
import 'package:flutter_ap/utils/widgets/custom_text_field.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Home page of app
class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      /// Initilizng Home bloc
      value: HomeBloc(),
      child: const HomePgBody(),
    );
  }
}

class HomePgBody extends StatefulWidget {
  const HomePgBody({super.key});

  @override
  State<HomePgBody> createState() => _HomeState();
}

class _HomeState extends State<HomePgBody> {
  late HomeBloc bloc;
  @override
  void didChangeDependencies() {
    ///  Intalizing bloc ot this widget
    bloc = context.read<HomeBloc>();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: const Key("HomePg"),
      backgroundColor: Theme.of(context).primaryColor,
      appBar: const HomeAppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _searchFieldWidget(),
          const Expanded(child: GameListView()),
        ],
      ),
    );
  }

  /// Search WIdget
  Widget _searchFieldWidget() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 8, 12, 5),
      child: CustomTextField(
          hint: 'Search',
          controller: bloc.searchTextController,
          onChange: (v) {
            /// On Search sending search event
            bloc.add(HomeSearchEvent(searchTxt: v ?? ""));
          },
          focusNode: bloc.searchTextFocusNode),
    );
  }
}

class GameListView extends StatelessWidget {
  const GameListView({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<HomeBloc>();
    return BlocConsumer<HomeBloc, HomeState>(
        buildWhen: (previous, current) {
          return current is! ErrorState;
        },
        listener: (context, state) {
          if (state is ErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content:
                    Text(state.error?.toString() ?? 'Error of Fetching Data')));
          }
        },
        /// Listening to bloc state to show game listing
        bloc: bloc,
        builder: (context, state) {
          if (state is LoadingState) {
            return const Center(
                child: CircularProgressIndicator(color: Colors.white));
          } else if (state is DataLoadedState || state is NoDataState) {
            /// on Data Loaded
            final datas =
                state is DataLoadedState ? state.datas : <GamesModel>[];
            if (datas.isEmpty) {
              return Center(
                child: Text("No Data Found",
                    style: Theme.of(context).textTheme.labelLarge),
              );
            } else {
              return ListView.builder(
                itemBuilder: (context, index) {
                  if (index == datas.length) {
                    /// Bottom Loader to show loading & notify to fetch data
                    return BottomLoader(onVisible: bloc.onLoadVisible);
                  }
                  return GameListTile(
                    game: datas[index],
                    onTap: () => bloc.onTapDetails(datas[index].id!, context),
                  );
                },
                itemCount: datas.length + 1,
              );
            }
          } else {
            /// No Satat Found
            return const Center(child: Text("State Not handled"));
          }
        });
  }
}
