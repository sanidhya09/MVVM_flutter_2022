import 'package:flutter/material.dart';
import 'package:list_view_flutter/RefreshListViewModel.dart';
import 'package:provider/provider.dart';

import 'RefreshIndicatorListView.dart';

void main() {
  runApp(MaterialApp(
    title: 'Flutter Demo',
    theme: ThemeData(
      primarySwatch: Colors.red,
    ),
    home: const MyHomePage(title: 'Flutter Demo Home Page'),
  ));
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => RefreshListViewModel()),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: const RefreshIndicatorView(),
      ),
    );
  }
}

