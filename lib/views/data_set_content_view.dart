import 'package:flutter/material.dart';

import 'package:zowe_flutter/enums/view_state.dart';
import 'package:zowe_flutter/models/data_set.dart';
import 'package:zowe_flutter/view_models/view_models.dart';
import 'package:zowe_flutter/views/shared/app_colors.dart';
import 'package:zowe_flutter/views/shared/ui_helpers.dart';
import 'package:zowe_flutter/views/base_view.dart';
import 'package:zowe_flutter/widgets/snack_bar.dart';

class DataSetContentView extends StatefulWidget {
  final DataSet dataSet;
  DataSetContentView({this.dataSet});

  @override
  _DataSetContentViewState createState() =>
      _DataSetContentViewState(dataSet: dataSet);
}

class _DataSetContentViewState extends State<DataSetContentView> {
  final TextEditingController _contentController = TextEditingController();
  DataSet dataSet;
  _DataSetContentViewState({this.dataSet});

  @override
  Widget build(BuildContext context) {
    print(dataSet.name);
    return BaseView<DataSetContentViewModel>(
      onModelReady: (model) => model
          .getDataSetContent(dataSet.name)
          .then((x) => _contentController.text = model.dataSetContent.records),
      builder: (context, model, child) => Scaffold(
          backgroundColor: backgroundColor,
          body: model.state == ViewState.Busy
              ? Center(child: CircularProgressIndicator())
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    UIHelper.verticalSpaceLarge(),
                    Row(
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: IconButton(
                              icon: Icon(Icons.arrow_back),
                              onPressed: () =>
                                  Navigator.pushNamed(context, 'dataSetList')),
                        ),
                        Expanded(
                          flex: 1,
                          child: IconButton(
                            icon: Icon(Icons.save),
                            onPressed: () async {
                              bool success = await model.updateDataSetContent(
                                  dataSet.name, _contentController.text);
                              if (success) {
                                CustomSnackBar(
                                        context: context,
                                        text: 'Data set content is updated!',
                                        backgroundColor: Colors.greenAccent)
                                    .showSnackBar();
                              } else {
                                CustomSnackBar(
                                        context: context,
                                        text:
                                            'Error! Data set content is not updated.',
                                        backgroundColor: Colors.orangeAccent)
                                    .showSnackBar();
                              }
                            },
                          ),
                        )
                      ],
                    ),
                    Text('Contents of ${dataSet.name}'),
                    Container(
                        padding: EdgeInsets.all(10.0),
                        height: 200.0,
                        child: TextField(
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          controller: _contentController,
                          decoration: InputDecoration(
                              contentPadding:
                                  EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                              hintText: "Password",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(0.0))),
                        )),
                    UIHelper.verticalSpaceMedium(),
                  ],
                )),
    );
  }
}
