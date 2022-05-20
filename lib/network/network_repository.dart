import 'package:list_view_flutter/api_status.dart';
import 'package:list_view_flutter/network/base_model.dart';
import 'package:list_view_flutter/network/server_error.dart';
import 'package:dio/dio.dart' hide Headers;
import 'api_client.dart';
import 'models/post.dart';

class NetworkRepository {
  late ApiClient apiClient;

  NetworkRepository() {
    apiClient = ApiClient();
  }

  Future<BaseModel<Post>> getResponseFromServer(int id) async {
    Post response;
    try {
      response = (await apiClient.getPostFromId(id));
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return BaseModel()
          .setException(ServerError.withError(error: (error as DioError)));
    }
    return BaseModel()..data = response;
  }

  Future<BaseModel<List<Post>>> getResponseListFromServer() async {
    List<Post> response;
    try {
      response = (await apiClient.getPosts("application/json"));
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return BaseModel()
          .setException(ServerError.withError(error: (error as DioError)));
    }
    return BaseModel()..data = response;
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

  void getResponseFromServer2(int id) {
    apiClient.getPostFromId(id).then((it) {
      //logger.i(it);
    }).catchError((Object obj) {
      // non-200 error goes here.
      switch (obj.runtimeType) {
        case DioError:
          BaseModel()
              .setException(ServerError.withError(error: (obj as DioError)));
          // logger.e("Got error : ${res.statusCode} -> ${res.statusMessage}");
          break;
        default:
          break;
      }
    });
  }
}
