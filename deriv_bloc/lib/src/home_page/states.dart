import 'package:deriv_bloc/deriv_bloc.dart';

class HomeState extends BaseState {}

class LoadingState extends HomeState {}

class LoadedState extends HomeState {
  final List<String> markets;
  final List<String> symbols;
  LoadedState(this.markets, this.symbols);
}

class ErrorLoadedState extends HomeState {
  String error;
  ErrorLoadedState({
    required this.error,
  });
}
