import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../my_list_modules/models/post.dart';

part 'api_client.g.dart';

const String BASE_URL = "https://jsonplaceholder.typicode.com";

@RestApi(baseUrl: BASE_URL)
abstract class ApiClient {
  factory ApiClient({String? baseUrl}) {
    Dio dio = Dio();
    dio.options = BaseOptions(
        receiveTimeout: 50000, connectTimeout: 50000, baseUrl: BASE_URL);
    dio.options.headers["Content-Type"] = "application/json";

    dio.interceptors.add(LogInterceptor(
        request: true,
        requestBody: true,
        requestHeader: true,
        responseBody: true,
        responseHeader: true));
    dio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
      return handler.next(options);
    }, onResponse: (response, handler) {
      log("interceptor" + response.data.toString());
      return handler.next(response);
    }, onError: (DioError e, handler) {
      return handler.next(e);
    }));
    return _ApiClient(dio, baseUrl: baseUrl);
  }

  @GET("/posts/{id}")
  Future<Post> getPostFromId(@Path("id") int postId);

  @GET("/posts")
  Future<List<Post>> getPosts(@Header("Content-Type") String contentType );

}
