import 'package:list_view_flutter/network/network_repository.dart';

class MyListServices {
  static Future<Object> getPostsListFromServer() async {
    return await NetworkRepository().getResponseListFromServer2();
  }
}
