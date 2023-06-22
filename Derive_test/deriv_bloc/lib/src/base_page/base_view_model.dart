// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:deriv_bloc/src/base_page/base_event.dart';
import 'package:deriv_bloc/src/base_page/base_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class BaseViewModel<T extends BaseEvent, S extends BaseState>
    extends Bloc<T, S> {
  BaseViewModel(super.initialState);
}
