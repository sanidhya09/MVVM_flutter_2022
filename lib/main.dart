import 'package:flutter/material.dart';
import 'package:list_view_flutter/network/network_repository.dart';
import 'network/base_model.dart';
import 'network/models/post.dart';

void main() {
  runApp(MaterialApp(
    title: 'Flutter Demo',
    theme: ThemeData(
      primarySwatch: Colors.red,
    ),
    home: const MyHomePage(title: 'Flutter Demo Home Page'),
  ));
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: _buildBodyList(context),
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
            subtitle: Text(posts![index].body),
          ),
        );
      },
      itemCount: posts!.length,
    );
  }
}
