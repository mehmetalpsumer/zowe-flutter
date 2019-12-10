import 'package:flutter/widgets.dart';

import 'package:zowe_flutter/enums/view_state.dart';

class BaseViewModel extends ChangeNotifier {
  ViewState _state = ViewState.Idle;

  ViewState get state => _state;

  void setState(ViewState viewState) {
    _state = viewState;
    notifyListeners();
  }
}
