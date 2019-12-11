import 'package:flutter/material.dart';

import 'package:zowe_flutter/enums/view_state.dart';
import 'package:zowe_flutter/view_models/login_view_model.dart';
import 'package:zowe_flutter/views/shared/app_colors.dart';
import 'package:zowe_flutter/views/base_view.dart';
import 'package:zowe_flutter/widgets/snack_bar.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  TextStyle style = TextStyle(fontSize: 20);

  @override
  Widget build(BuildContext context) {
    final usernameField = TextField(
      obscureText: false,
      controller: _usernameController,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Username",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );

    final passwordField = TextField(
      obscureText: true,
      controller: _passwordController,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Password",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );

    return BaseView<LoginViewModel>(
      builder: (context, model, child) => Scaffold(
          backgroundColor: backgroundColor,
          body: Builder(
            builder: (BuildContext context) {
              return Center(
                child: Container(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(36.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          height: 155.0,
                          child: Image.asset(
                            "assets/zowe.png",
                            fit: BoxFit.contain,
                          ),
                        ),
                        SizedBox(height: 45.0),
                        usernameField,
                        SizedBox(height: 25.0),
                        passwordField,
                        SizedBox(
                          height: 35.0,
                        ),
                        model.state == ViewState.Busy
                            ? CircularProgressIndicator()
                            : Material(
                                elevation: 5.0,
                                borderRadius: BorderRadius.circular(30.0),
                                color: primaryColor,
                                child: MaterialButton(
                                  minWidth: MediaQuery.of(context).size.width,
                                  padding: EdgeInsets.fromLTRB(
                                      20.0, 15.0, 20.0, 15.0),
                                  onPressed: () async {
                                    final username = _usernameController.text;
                                    final password = _passwordController.text;

                                    // Handle empty inputs
                                    if (username == "") {
                                      CustomSnackBar(
                                        context: context,
                                        text: 'Username can\'t be empty!',
                                        backgroundColor: Colors.orange,
                                      ).showSnackBar();
                                      return;
                                    }

                                    if (password == "") {
                                      CustomSnackBar(
                                        context: context,
                                        text: 'Password can\'t be empty!',
                                        backgroundColor: Colors.orange,
                                      ).showSnackBar();
                                      return;
                                    }

                                    // Wait for login
                                    var loginSuccess =
                                        await model.login(username, password);

                                    // Redirect to home page
                                    if (!loginSuccess) {
                                      CustomSnackBar(
                                        context: context,
                                        text:
                                            'Login failed, check your credentials.',
                                        backgroundColor: Colors.orange,
                                      ).showSnackBar();
                                      return;
                                    }

                                    CustomSnackBar(
                                      context: context,
                                      text: 'Login successful!',
                                      backgroundColor: Colors.lightGreen,
                                    ).showSnackBar();
                                    Navigator.pushNamed(context, '/');
                                  },
                                  child: Text("Login",
                                      textAlign: TextAlign.center,
                                      style: style.copyWith(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold)),
                                ),
                              ),
                        SizedBox(
                          height: 15.0,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          )),
    );
  }
}
