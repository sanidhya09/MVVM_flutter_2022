import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'RefreshIndicatorListView.dart';
import 'RefreshListViewModel.dart';

class FirstFragment extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => RefreshListViewModel()),
      ],
      child: const Scaffold(
        body: RefreshIndicatorView(),
      ),
    );
  }
}