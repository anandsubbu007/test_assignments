import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pet_adoption_app/db/storage_manager.dart';
import 'package:pet_adoption_app/model/pet_model.dart';
import 'package:pet_adoption_app/repo/repo.dart';
import 'package:pet_adoption_app/src/details/bloc/details_bloc.dart';
import 'package:pet_adoption_app/src/home/bloc/home_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mocktail/mocktail.dart';

import 'storage_test.dart';

// PetRepo
class MockPetRepo extends Mock implements PetRepo {}

void main() {
  SharedPreferences secureStorage = MockSecureStorage();
  late HomeBloc bloc;
  late DetailsBloc detailBloc;
  MockPetRepo repo = MockPetRepo();
  setUp(() async {
    await AppStorageManager.instance.init(secureStorage);
    bloc = HomeBloc(repo);
    detailBloc = DetailsBloc(id: "1", repo: repo);
  });

  group('Bloc test', () {
    when(() => repo.getPetData(limit: 10)).thenAnswer((_) async => [petA]);
    when(() => repo.getById("1")).thenAnswer((_) async => petA);

    blocTest<HomeBloc, HomeState>(
      'emits onData State',
      build: () => bloc,
      act: (cubit) => cubit.add(HomeSearchEvent()),
      expect: () => [
        DataLoadedState(datas: [petA])
      ],
    );
    tearDown(() {
      detailBloc.close();
      bloc.close();
    });
  });
}

final petA = PetModel(
    image: "",
    name: "Pupy",
    description: "",
    rate: 300,
    price: "200",
    id: "1",
    color: "Black",
    age: "22",
    sex: "Male");
List<PetModel> sample = [petA];
