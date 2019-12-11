import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:zowe_flutter/models/models.dart';
import 'package:zowe_flutter/views/views.dart';

const String initialRoute = "login";

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case 'login':
        return MaterialPageRoute(builder: (_) => LoginView());
      case '/':
        return MaterialPageRoute(builder: (_) => HomeView());
      case 'dataSetList':
        return MaterialPageRoute(builder: (_) => DataSetListView());
      case 'dataSetContent':
        var dataSet = settings.arguments as DataSet;
        return MaterialPageRoute(
            builder: (_) => DataSetContentView(dataSet: dataSet));
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                    child: Text('404 ${settings.name} route not found.'),
                  ),
                ));
    }
  }
}
