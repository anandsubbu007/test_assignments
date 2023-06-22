import 'package:deriv_bloc/base_page_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'base_page_view_model.dart';

/// Every Page/View should be inherited from this
abstract class BasePage<VM extends BasePageViewModel> extends StatefulWidget {
  const BasePage({Key? key}) : super(key: key);
}

///
abstract class BasePageState<VM extends BasePageViewModel,
    T extends BasePage<VM>> extends CoreBasePageState<VM, T> {}

///
abstract class BaseStatefulPage<VM extends BasePageViewModel,
    B extends BasePage<VM>> extends BasePageState<VM, B> {
  VM get model;
  @override
  Widget build(BuildContext context) {
    return getLayout(model);
  }
}

///
abstract class BasePageViewWidget<T extends BasePageViewModel> extends Widget {
  final T bloc;

  const BasePageViewWidget(this.bloc, {super.key});

  @protected
  Widget build(BuildContext context, T model);

  @override
  // ignore: library_private_types_in_public_api
  _DataProviderElement<T> createElement() =>
      _DataProviderElement<T>(this, bloc);
}

class _DataProviderElement<T extends BasePageViewModel>
    extends ComponentElement {
  final T bloc;

  _DataProviderElement(BasePageViewWidget widget, this.bloc) : super(widget);

  @override
  BasePageViewWidget get widget => super.widget as BasePageViewWidget;

  @override
  Widget build() {
    return BlocProvider<T>(
      create: (context) {
        return bloc;
      },
      child: widget.build(this, bloc),
    );
  }
}
