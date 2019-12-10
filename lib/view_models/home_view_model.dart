import 'package:zowe_flutter/view_models/base_view_model.dart';
import 'package:zowe_flutter/service_locator.dart';
import 'package:zowe_flutter/services/auth.dart';
import 'package:zowe_flutter/enums/view_state.dart';

class HomeViewModel extends BaseViewModel {
  final AuthService _authenticationService = sl<AuthService>();

  bool logout() {
    setState(ViewState.Busy);

    var success = _authenticationService.logout();
    setState(ViewState.Idle);
    return success;
  }
}