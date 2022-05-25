import 'package:list_view_flutter/network/my_client.dart';

class NetworkRepository {

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
