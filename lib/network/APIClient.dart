import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:http/retry.dart';

import 'api_status.dart';

class APIClient {
  static final APIClient _singleton = APIClient._internal();

  factory APIClient() {
    return _singleton;
  }
  APIClient._internal();

  static String BASE_URL = kReleaseMode
      ? "jsonplaceholder.typicode.com"
      : "jsonplaceholder.typicode.com";

  Future<Object> makeApiRequest(String url, String type,
      Map<String, dynamic> data, bool enableRetry) async {
    http.Client client;
    if (enableRetry) {
      client = RetryClient(http.Client());
    } else {
      client = http.Client();
    }
    try {
      var response = await client
          .get(Uri.https(BASE_URL, url), headers: _buildHeaders(false))
          .timeout(const Duration(seconds: 10));
      print("HTTP_RESPONSE::${response.statusCode}");
      print("HTTP_RESPONSE::${response.body}");
      if (response.statusCode == 200) {
        return Success(response.body);
      } else {
        return Failure("HTTP_RESPONSE_FAILED::${response.statusCode}");
      }
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return Failure(error.toString());
    } finally {
      client.close();
    }
  }

  /// build the headers for the given request. might include authorization or any number of other headers
  Map<String, String> _buildHeaders(bool requiresAuth) {
    final Map<String, String> headers = <String, String>{
      'Accept': 'application/json; charset=utf-8',
      'User-Agent': 'AppName (version: 1.0.0)',
    };

    if (requiresAuth) {
      headers['Authorization'] = 'Bearer _ xyz';
    }

    return headers;
  }
}
