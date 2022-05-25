import 'package:flutter/material.dart';

class SecondFragment extends StatelessWidget {
  bool fromWhichScreen;
  SecondFragment(this.fromWhichScreen, {Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar:  fromWhichScreen ? AppBar(
          leading:  BackButton(
              color: Colors.white,
              onPressed: () => Navigator.of(context).pop(),
          ),
          title: const Text("Detail Fragment")
        ):null,
        body: const Center(
          child: Text('Hello World'),
        ),
      ),
    );
  }
}
