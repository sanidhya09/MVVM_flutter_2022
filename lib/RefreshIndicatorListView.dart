import 'package:flutter/material.dart';
import 'network/models/post.dart';
import 'network/base_model.dart';
import 'package:list_view_flutter/network/network_repository.dart';

class RefreshIndicatorView extends StatefulWidget {
  const RefreshIndicatorView({Key? key}) : super(key: key);

  @override
  _RefreshIndicatorViewState createState() => _RefreshIndicatorViewState();
}

class _RefreshIndicatorViewState extends State<RefreshIndicatorView> {

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      displacement: 250,
      backgroundColor: Colors.yellow,
      color: Colors.red,
      strokeWidth: 3,
      triggerMode: RefreshIndicatorTriggerMode.onEdge,
      onRefresh: () async {
        setState(() {
          _buildBodyList(context);
        });
      },
      child: Scaffold(
        backgroundColor: const Color(0xff246df8),
        body: _buildBodyList(context),
      ),
    );
  }

  // build list view & manage states
  FutureBuilder<BaseModel<List<Post>>> _buildBodyList(BuildContext context) {
    return FutureBuilder<BaseModel<List<Post>>>(
      future: NetworkRepository().getResponseListFromServer(),
      builder: (context, baseModel) {
        if (baseModel.connectionState == ConnectionState.done) {
          final List<Post>? posts = baseModel.data?.data;
          return _buildListView(context, posts);
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget _buildListView(BuildContext context, List<Post>? posts) {
    return ListView.builder(
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              leading: const Icon(
                Icons.account_box,
                color: Colors.green,
                size: 50,
              ),
              title: Text(
                posts![index].title,
                style: const TextStyle(fontSize: 20),
              ),
              subtitle: Text(posts[index].body),
            ),
          );
        },
        itemCount: posts!.length,
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        scrollDirection: Axis.vertical);
  }
}
