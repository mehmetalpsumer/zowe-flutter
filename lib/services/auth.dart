import 'dart:async';
import 'dart:convert';

import 'package:zowe_flutter/env.dart';
import 'package:zowe_flutter/models/user.dart';
import 'package:zowe_flutter/services/api.dart';

class AuthService {
  StreamController<User> userController = new StreamController<User>();
  static User user;

  /// Attempts to login to Auth server.
  Future<bool> login(String username, String password) async {
    var fetchedUser = await _login(username, password);

    bool hasUser = fetchedUser != null;
    if (hasUser) {
      userController.add(fetchedUser);
      user = fetchedUser;
    }

    return hasUser;
  }

  bool logout() {
    // If there is no authentication currently, fail to log out.
    if (user == null) {
      return false;
    }

    // Clear user data
    user = null;
    return true;
  }

  /// POSTs credentials to Auth server.
  Future<User> _login(String username, String password) async {
    var data = {'username': username, 'password': password};

    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    // Send credentials as JSON and asnyc wait for the response.
    var response = await ApiService.ioClient
        .post(DevEnv.authUrl, headers: headers, body: jsonEncode(data));

    // Parse success field to determine if auth was succeeded.
    bool success = json.decode(response.body)['success'];
    if (!success) {
      return null;
    }

    // Create auth token and create User object.
    // TODO; Is it good idea to store token?
    String rawUser = username + ':' + password;
    List<int> bytes = utf8.encode(rawUser);
    String base64User = base64.encode(bytes);
    return User(username: username, token: base64User);
  }
}
