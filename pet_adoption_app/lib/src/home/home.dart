import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_adoption_app/src/home/bloc/home_bloc.dart';
import 'package:pet_adoption_app/src/home/widgets/app_bar.dart';
import 'package:pet_adoption_app/src/home/widgets/pet_widget.dart';
import 'package:pet_adoption_app/utils/widgets/bottom_loader.dart';
import 'package:pet_adoption_app/utils/widgets/custom_text_field.dart';

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
          const Expanded(
              child: PetListView(
            key: Key("PetListView"),
          )),
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

class PetListView extends StatelessWidget {
  const PetListView({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<HomeBloc>();
    return BlocBuilder<HomeBloc, HomeState>(

        /// Listening to bloc state to show pet listing
        bloc: bloc,
        builder: (context, state) {
          if (state is LoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is DataLoadedState || state is NoDataState) {
            /// on Data Loaded
            final petsList = state is DataLoadedState ? state.datas : [];
            if (petsList.isEmpty) {
              return Center(
                child: Text("No Data Found",
                    style: Theme.of(context).textTheme.labelLarge),
              );
            } else {
              return ListView.builder(
                key: const Key('petList'),
                itemBuilder: (context, index) {
                  if (index == petsList.length) {
                    /// Bottom Loader to show loading & notify to fetch data
                    return BottomLoader(onVisible: bloc.onLoadVisible);
                  }
                  return PetWidget(
                    key: Key('petList_$index'),
                    pet: petsList[index],
                    onTap: () => bloc.onTapDetails(petsList[index].id, context),
                  );
                },
                itemCount: petsList.length + 1,
              );
            }
          } else {
            /// No Satat Found
            return const Center(child: Text("State Not handled"));
          }
        });
  }
}
