import 'package:deriv_bloc/src/base_page/base_state.dart';
import 'package:deriv_bloc/src/base_page/base_view_model.dart';

class BasePageViewModel<S extends BaseState> extends BaseViewModel<S> {
  BasePageViewModel(super.initialState);
}
