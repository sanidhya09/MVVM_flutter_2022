import 'dart:convert';

import 'package:flutter/material.dart';

import '../network/api_status.dart';
import 'models/post.dart';
import 'my_list_services.dart';

class RefreshListViewModel extends ChangeNotifier {
  bool _loading = false;
  List<Post> _postListModel = [];

  bool get loading => _loading;

  List<Post> get postListModel => _postListModel;

  setLoading(bool loading) async {
    _loading = loading;
    notifyListeners();
  }

  setUserListModel(List<Post> post) {
    _postListModel = post;
  }

  getPostList() async {
    setLoading(true);
    var response = await MyListServices.getPostsListFromServer();
    if (response is Success) {
      List<dynamic> decodeJson = json.decode(response.response.toString());
      List<Post> _postListModel = [];
      for (int i = 0; i <= decodeJson.length - 1; i++) {
        var post = Post.fromJson(decodeJson[i]);
        _postListModel.add(post);
      }
      setUserListModel(_postListModel);
    }
    if (response is Failure) {
      //DO something
    }
    setLoading(false);
  }
}
