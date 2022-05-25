import 'package:list_view_flutter/network/NetworkRepository.dart';

class MyListServices {
  static Future<Object> getPostsListFromServer() async {
    return await NetworkRepository().makeGetRequest("/posts");
  }
}
