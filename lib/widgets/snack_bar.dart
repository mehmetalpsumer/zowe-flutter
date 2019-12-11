import 'package:flutter/material.dart';

class CustomSnackBar extends StatelessWidget {
  BuildContext context;
  String text;
  Color backgroundColor;
  Color textColor;
  int duration; //seconds
  GlobalKey<ScaffoldState> scaffoldKey;

  CustomSnackBar(
      {this.scaffoldKey,
      @required this.context,
      this.textColor: Colors.white,
      this.backgroundColor = Colors.black12,
      @required this.text,
      this.duration = 3});

  void showSnackBar() {
    scaffoldKey == null
        ? Scaffold.of(context).showSnackBar(customSnackBar())
        : scaffoldKey.currentState.showSnackBar(customSnackBar());
  }

  @override
  Widget build(BuildContext context) {
    return customSnackBar();
  }

  Widget customSnackBar() {
    return SnackBar(
      content: Text(
        text,
        style: TextStyle(color: textColor, fontSize: 20),
      ),
      backgroundColor: backgroundColor,
      duration: Duration(seconds: duration),
    );
  }
}
