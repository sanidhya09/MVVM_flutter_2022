import 'package:dio/dio.dart' hide Headers;
import 'package:list_view_flutter/network/api_status.dart';
import 'package:list_view_flutter/network/server_error.dart';

import '../my_list_modules/models/post.dart';
import 'api_client.dart';

class NetworkRepository {
  late ApiClient apiClient;

  NetworkRepository() {
    apiClient = ApiClient();
  }

  Future<Object> getResponseListFromServer2() async {
    List<Post> responseFromServer;
    try {
      responseFromServer = (await apiClient.getPosts("application/json"));
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return Failure(ServerError.withError(error: (error as DioError)));
    }
    return Success(responseFromServer);
  }
}
