import 'package:deriv_bloc/deriv_bloc.dart';

class HomeState extends BaseState {
}

class LoadingState extends HomeState {
  @override
  List<Object?> get props => ['LoadingState'];
}

class LoadedState extends HomeState {
  final List<String> markets;
  final List<String> symbols;
  LoadedState(this.markets, this.symbols);
  @override
  List<Object?> get props => [...markets, ...symbols];
}

// ignore: must_be_immutable
class ErrorLoadedState extends HomeState {
  String error;
  ErrorLoadedState({
    required this.error,
  });
  @override
  List<Object?> get props => [error];
}
