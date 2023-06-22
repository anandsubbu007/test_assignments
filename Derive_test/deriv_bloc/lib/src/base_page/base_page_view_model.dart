import 'package:deriv_bloc/src/base_page/base_event.dart';
import 'package:deriv_bloc/src/base_page/base_state.dart';
import 'package:deriv_bloc/src/base_page/base_view_model.dart';

class BasePageViewModel<T extends BaseEvent, S extends BaseState>
    extends BaseViewModel<T, S> {
  BasePageViewModel(super.initialState);
}
