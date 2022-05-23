import 'package:flutter/material.dart';
import 'package:list_view_flutter/RefreshListViewModel.dart';
import 'package:list_view_flutter/SecondFragment.dart';
import 'package:provider/provider.dart';

import 'network/models/post.dart';

class RefreshIndicatorView extends StatefulWidget {
  const RefreshIndicatorView({Key? key}) : super(key: key);

  @override
  _RefreshIndicatorViewState createState() => _RefreshIndicatorViewState();
}

class _RefreshIndicatorViewState extends State<RefreshIndicatorView> {
  @override
  Widget build(BuildContext context) {
    RefreshListViewModel refreshListViewModel =
        context.watch<RefreshListViewModel>();
    return RefreshIndicator(
      displacement: 250,
      backgroundColor: Colors.grey,
      color: Colors.black38,
      strokeWidth: 3,
      triggerMode: RefreshIndicatorTriggerMode.onEdge,
      onRefresh: () async {
        refreshListViewModel.postListModel.clear();
        setState(() {
          _buildBodyList(context, refreshListViewModel);
        });
      },
      child: Scaffold(
        backgroundColor:  Colors.black12,
        body: _buildBodyList(context, refreshListViewModel),
      ),
    );
  }

  // build list view & manage states
  _buildBodyList(
      BuildContext context, RefreshListViewModel refreshListViewModel) {
    if (refreshListViewModel.loading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    if (refreshListViewModel.postListModel.isNotEmpty) {
      return _buildListView(context, refreshListViewModel.postListModel);
    }
    refreshListViewModel.getPostList();
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
              title: Text(posts![index].title,
                  style: const TextStyle(fontSize: 20),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis),
              subtitle: Text(posts[index].body,
                  maxLines: 4, overflow: TextOverflow.ellipsis),
              onTap: () => openDetailPage(context),
            ),
          );
        },
        itemCount: posts!.length,
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        scrollDirection: Axis.vertical);
  }

  openDetailPage(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => SecondFragment(true)));
  }
}
