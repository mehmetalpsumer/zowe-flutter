import 'package:zowe_flutter/view_models/base_view_model.dart';
import 'package:zowe_flutter/enums/view_state.dart';
import 'package:zowe_flutter/services/auth.dart';
import 'package:zowe_flutter/service_locator.dart';

class LoginViewModel extends BaseViewModel {
  final AuthService _authenticationService = sl<AuthService>();

  String errorMessage;

  Future<bool> login(String username, String password) async {
    setState(ViewState.Busy);
    var success = await _authenticationService.login(username, password);
    setState(ViewState.Idle);
    return success;
  }
}
