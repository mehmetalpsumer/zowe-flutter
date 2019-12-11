import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:zowe_flutter/enums/view_state.dart';
import 'package:zowe_flutter/models/data_set.dart';
import 'package:zowe_flutter/models/user.dart';
import 'package:zowe_flutter/view_models/data_set_list_view_model.dart';
import 'package:zowe_flutter/views/shared/app_colors.dart';
import 'package:zowe_flutter/views/shared/ui_helpers.dart';
import 'package:zowe_flutter/views/base_view.dart';

class DataSetListView extends StatefulWidget {
  @override
  _DataSetListViewState createState() => _DataSetListViewState();
}

class _DataSetListViewState extends State<DataSetListView> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController _filterController =
        TextEditingController(text: Provider.of<User>(context).username);
    final filterField = TextField(
      obscureText: false,
      controller: _filterController,
      decoration: InputDecoration(
          hintText: "Filter",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );

    return BaseView<DataSetListViewModel>(
      onModelReady: (model) =>
          model.filterDataSets(Provider.of<User>(context).username),
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
                                  Navigator.pushNamed(context, '/')),
                        ),
                        Expanded(flex: 3, child: filterField),
                        Expanded(
                          flex: 1,
                          child: IconButton(
                            icon: Icon(Icons.search),
                            onPressed: () =>
                                {model.filterDataSets(_filterController.text)},
                          ),
                        )
                      ],
                    ),
                    UIHelper.verticalSpaceMedium(),
                    Expanded(child: getDataSetsUi(model.dataSetList)),
                  ],
                )),
    );
  }

  Widget getDataSetsUi(DataSetList dataSetList) => ListView.builder(
      itemCount: dataSetList.dataSets.length,
      itemBuilder: (context, index) => DataSetListItem(
            dataSet: dataSetList.dataSets[index],
          ));
}

class DataSetListItem extends StatelessWidget {
  final DataSet dataSet;
  const DataSetListItem({this.dataSet});

  @override
  Widget build(BuildContext context) {
    String dsOrg = '';
    switch (dataSet.dataSetOrganization) {
      case '':
        dsOrg = 'User Catalog';
        break;
      case 'PS':
        dsOrg = 'Sequential';
        break;
      case 'PO':
      case 'PO_E':
        dsOrg = 'Partitioned';
        break;
      default:
        dsOrg = 'Other';
    }

    return GestureDetector(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
        padding: EdgeInsets.all(1.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            color: backgroundColor,
            boxShadow: [
              BoxShadow(
                  blurRadius: 3.0,
                  offset: Offset(0.0, 2.0),
                  color: Color.fromARGB(80, 0, 0, 0))
            ]),
        child: Row(
          children: <Widget>[
            Column(
              children: <Widget>[
                Icon(Icons.folder),
              ],
            ),
            UIHelper.horizontalSpaceSmall(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  dataSet.name,
                  style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16.0),
                ),
                dataSet.dataSetOrganization != null
                    ? Text(
                        dsOrg,
                        style: TextStyle(
                            fontWeight: FontWeight.w900, fontSize: 10.0),
                      )
                    : Container(),
              ],
            ),
          ],
        ),
      ),
      onTap: () async {
        switch (dataSet.dataSetOrganization) {
          case 'PS':
            print('Passing ds name: ${dataSet.name}');
            Navigator.pushNamed(context, 'dataSetContent', arguments: dataSet);
            break;
          case 'PO':
          case 'PO_E':
            Navigator.pushNamed(context, 'dataSetMembers', arguments: dataSet);
            break;
          default:
            print('Not supported');
        }
      },
    );
  }
}
