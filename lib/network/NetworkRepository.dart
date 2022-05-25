import 'package:list_view_flutter/network/APIClient.dart';

class NetworkRepository {
  static final NetworkRepository _singleton = NetworkRepository._internal();

  factory NetworkRepository() {
    return _singleton;
  }
  NetworkRepository._internal();


  Future<Object> makeGetRequest(String url) async {
    var myClient = APIClient();
    Map<String, dynamic> data = {};
    return await myClient.makeApiRequest(url, "GET", data, false);
  }

  Future<Object> makePostRequest(String url, Map<String, dynamic> data) async {
    var myClient = APIClient();
    return await myClient.makeApiRequest(url, "POST", data, false);
  }
}
