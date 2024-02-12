import 'package:flutter/foundation.dart';

import '../enums/view_state.dart';

/// This is BaseViewModel
/// Every View Model must extend this BaseViewModel

class BaseViewModel extends ChangeNotifier {
  ViewState _state = ViewState.idle;

  ViewState get state => _state;

  void setViewState(ViewState viewState) {
    _state = viewState;
    notifyListeners();
  }
}
