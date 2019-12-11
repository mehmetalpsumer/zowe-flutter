import 'dart:async';
import 'dart:convert';

import 'package:zowe_flutter/models/data_set.dart';
import 'package:zowe_flutter/models/data_set_content.dart';
import 'package:zowe_flutter/services/services.dart';

class DataSetService {
  /// Get list of data sets with filter.
  Future<DataSetList> filterDataSets(String filterString) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Basic ' + AuthService.user.token,
    };

    final url = '${ApiService.DATA_SET_ENDPOINT}/$filterString';
    var response = await ApiService.ioClient.get(url, headers: headers);
    var jsonBody = json.decode(response.body);
    return DataSetList.fromJson(jsonBody['items']);
  }

  /// Get data set content.
  Future<DataSetContent> getDataSetContent(String dataSetName) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Basic ' + AuthService.user.token,
    };

    final url = '${ApiService.DATA_SET_ENDPOINT }/$dataSetName/content';
    var response = await ApiService.ioClient.get(url, headers: headers);
    var jsonBody = json.decode(response.body);
    return DataSetContent.fromJson(jsonBody);
  }

  /// Update contents of data set.
  Future<bool> updateDataSetContent(String dataSetName, String content) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Basic ' + AuthService.user.token,
    };

    var data = {'records': content};
    var dataJson = json.encode(data);

    final url = '${ApiService.DATA_SET_ENDPOINT}/$dataSetName/content';
    var response =
        await ApiService.ioClient.put(url, headers: headers, body: dataJson);

    return response.statusCode == 200 || response.statusCode == 201;
  }
}
