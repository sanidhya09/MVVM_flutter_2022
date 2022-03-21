import 'package:flutter/material.dart';
import 'package:list_view_flutter/network/network_repository.dart';
import 'RefreshIndicatorListView.dart';
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
      body: const RefreshIndicatorView(),
    );
  }
}
