import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:zowe_flutter/view_models/home_view_model.dart';
import 'package:zowe_flutter/models/user.dart';
import 'package:zowe_flutter/views/shared/app_colors.dart';
import 'package:zowe_flutter/views/base_view.dart';
import 'package:zowe_flutter/views/shared/text_styles.dart';
import 'package:zowe_flutter/widgets/snack_bar.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  TextStyle style = TextStyle(fontSize: 32, fontWeight: FontWeight.bold);


  @override
  Widget build(BuildContext context) {
    return BaseView<HomeViewModel>(
      builder: (context, model, child) => Scaffold(
        backgroundColor: backgroundColor,
        body: Builder(
          builder: (BuildContext context) {
            return Center(
              child: MaterialApp(
                title: 'Test',
                home: Scaffold(
                  appBar: AppBar(
                    title: Text('Welcome ${Provider.of<User>(context).username}'),
                  ),
                  body: GridView.count(
                    // Create a grid with 2 columns. If you change the scrollDirection to
                    // horizontal, this produces 2 rows.
                    crossAxisCount: 2,
                    // Generate 100 widgets that display their index in the List.
                    children: [
                      // Data sets
                      new GestureDetector(
                        onTap: (){
                          print("Container clicked");
                        },
                        child: new Container(
                          alignment: Alignment.center,
                          width: 150.0,
                          height: 150.0,
                          padding: new EdgeInsets.fromLTRB(20.0, 40.0, 20.0, 40.0),
                          margin: new EdgeInsets.all(5.0),
                          color: Colors.black12,
                          child: new Column(
                              children: [
                                Center(
                                  child: Image.asset(
                                    "assets/data_set.png",
                                    width: 75.0,
                                    height: 75.0,
                                    alignment: Alignment.center,
                                  )
                                ),  
                                Center(child: Text("Data Sets", style: headerStyle,),)
                              ]
                          ),
                        )
                      ),
                      // Jobs
                      new GestureDetector(
                        onTap: (){
                          print("Container clicked");
                        },
                        child: new Container(
                          alignment: Alignment.center,
                          width: 150.0,
                          height: 150.0,
                          padding: new EdgeInsets.fromLTRB(20.0, 40.0, 20.0, 40.0),
                          margin: new EdgeInsets.all(5.0),
                          color: Colors.black12,
                          child: new Column(
                              children: [
                                Icon(
                                  Icons.assignment,
                                  size: 75.0,
                                ),
                                /*Image.asset(
                                  "assets/job.png",
                                  width: 75.0,
                                  height: 75.0,
                                  alignment: Alignment.center,
                                ),*/
                                new Text("Jobs", style: headerStyle,),
                              ]
                          ),
                        )
                      ),
                      // Logout
                      new GestureDetector(
                        onTap: (){
                          bool logoutSuccess = model.logout();

                          if (logoutSuccess) {
                            Navigator.pushNamed(context, 'login');
                          } else {
                            CustomSnackBar(context:context, text: 'Error while logging out...',);
                          }
                        },
                        child: new Container(
                          alignment: Alignment.center,
                          width: 150.0,
                          height: 150.0,
                          padding: new EdgeInsets.fromLTRB(20.0, 40.0, 20.0, 40.0),
                          margin: new EdgeInsets.all(5.0),
                          color: Colors.black12,
                          child: new Column(
                              children: [
                                Icon(
                                  Icons.exit_to_app,
                                  size: 75.0,
                                ),
                                /*Image.asset(
                                  "assets/job.png",
                                  width: 75.0,
                                  height: 75.0,
                                  alignment: Alignment.center,
                                ),*/
                                new Text("Logout", style: headerStyle,),
                              ]
                          ),
                        )
                      ),
                    ]
                  ),
                ),
              ),
            );
          },
        )
      ),
    );
  }
}

class HomeGridItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
  }
}