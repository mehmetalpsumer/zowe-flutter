import 'package:zowe_flutter/models/data_set.dart';
import 'package:zowe_flutter/models/data_set_content.dart';
import 'package:zowe_flutter/view_models/base_view_model.dart';
import 'package:zowe_flutter/enums/view_state.dart';
import 'package:zowe_flutter/services/data_set.dart';
import 'package:zowe_flutter/service_locator.dart';

class DataSetContentViewModel extends BaseViewModel {
  final DataSetService _dataSetService = sl<DataSetService>();
  DataSet dataSet;
  DataSetContent dataSetContent;

  Future<DataSetContent> getDataSetContent(String dataSetName) async {
    setState(ViewState.Busy);
    var result = await _dataSetService.getDataSetContent(dataSetName);
    dataSetContent = result;
    setState(ViewState.Idle);
    return result;
  }

  Future<bool> updateDataSetContent(String dataSetName, String content) async {
    setState(ViewState.Busy);
    var result =
        await _dataSetService.updateDataSetContent(dataSetName, content);
    dataSetContent.records = content;
    setState(ViewState.Idle);
    return result;
  }
}
