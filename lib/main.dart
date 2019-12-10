import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:logger/logger.dart';

import 'package:zowe_flutter/service_locator.dart';
import 'package:zowe_flutter/router.dart';
import 'package:zowe_flutter/services/auth.dart';
import 'package:zowe_flutter/models/user.dart';

var logger = Logger(
  printer: PrettyPrinter(),
);

void main() {
  setUpServiceLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>(
      initialData: User.initial(),
      builder: (context) => sl<AuthService>().userController.stream,
      child: MaterialApp(
        title: 'Zowe Flutter',
        theme: ThemeData(),
        initialRoute: 'login',
        onGenerateRoute: Router.generateRoute,
      ),
    );
  }
}
