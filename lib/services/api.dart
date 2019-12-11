import 'dart:io';
import 'package:http/io_client.dart';

import 'package:zowe_flutter/env.dart';

class ApiService {
  static const AUTH_ENDPOINT = DevEnv.authUrl;
  static const API_ENDPOINT = DevEnv.apiUrl;

  static HttpClient httpClient = new HttpClient()
    ..badCertificateCallback =
        ((X509Certificate cert, String host, int port) => true);
  static IOClient ioClient = new IOClient(httpClient);
}
