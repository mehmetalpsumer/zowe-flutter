import 'package:zowe_flutter/models/data_set.dart';
import 'package:zowe_flutter/view_models/base_view_model.dart';
import 'package:zowe_flutter/enums/view_state.dart';
import 'package:zowe_flutter/services/data_set.dart';
import 'package:zowe_flutter/service_locator.dart';

class DataSetListViewModel extends BaseViewModel {
  final DataSetService _dataSetService = sl<DataSetService>();
  DataSetList dataSetList;

  Future<DataSetList> filterDataSets(String filterString) async {
    setState(ViewState.Busy);
    var result = await _dataSetService.filterDataSets(filterString);
    dataSetList = result;
    setState(ViewState.Idle);
    return result;
  }
}
