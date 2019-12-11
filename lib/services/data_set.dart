import 'dart:async';
import 'dart:convert';

import 'package:zowe_flutter/models/data_set.dart';
import 'package:zowe_flutter/models/data_set_content.dart';
import 'package:zowe_flutter/services/services.dart';

class DataSetService {
  /// GET request to datasets with filter parameter.
  Future<DataSetList> filterDataSets(String filterString) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Basic ' + AuthService.user.token,
    };

    final url = ApiService.API_ENDPOINT + '/api/v1/datasets/' + filterString;
    var response = await ApiService.ioClient.get(url, headers: headers);
    print(response.toString());
    print('Url: $url');
    print('Status: ${response.statusCode}');
    print('Body: ${response.body}');

    var jsonBody = json.decode(response.body);
    print('Json Body: $jsonBody');
    return DataSetList.fromJson(jsonBody['items']);
  }

  /// GET request to datasets/content with data set name.
  Future<DataSetContent> getDataSetContent(String dataSetName) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Basic ' + AuthService.user.token,
    };

    final url = ApiService.API_ENDPOINT +
        '/api/v1/datasets/' +
        dataSetName +
        '/content';
    var response = await ApiService.ioClient.get(url, headers: headers);
    var jsonBody = json.decode(response.body);
    return DataSetContent.fromJson(jsonBody);
  }

  /// PUT request to update content of a data set
  Future<bool> updateDataSetContent(String dataSetName, String content) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Basic ' + AuthService.user.token,
    };

    var data = {'records': content};
    var dataJson = json.encode(data);

    final url = ApiService.API_ENDPOINT +
        '/api/v1/datasets/' +
        dataSetName +
        '/content';
    var response =
        await ApiService.ioClient.put(url, headers: headers, body: dataJson);

    return response.statusCode == 200 || response.statusCode == 201;
  }
}
