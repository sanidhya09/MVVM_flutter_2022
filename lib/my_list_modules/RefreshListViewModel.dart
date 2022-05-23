import 'package:flutter/material.dart';
import 'package:list_view_flutter/network/server_error.dart';

import '../network/api_status.dart';
import 'models/post.dart';
import 'my_list_services.dart';
import '../network/network_repository.dart';

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
      setUserListModel(response.response as List<Post>);
    }
    if (response is Failure) {
      print((response.errorResponse as ServerError).getErrorMessage());
    }
    setLoading(false);
  }
}
