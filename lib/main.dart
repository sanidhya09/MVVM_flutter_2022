import 'package:flutter/material.dart';

import 'my_camera_module/SecondFragment.dart';
import 'my_list_modules/FirstFragment.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyHomePage(),
  ));
}

class DrawerItem {
  String title;
  IconData icon;

  DrawerItem(this.title, this.icon);
}

class MyHomePage extends StatefulWidget {
  final drawerItems = [
    DrawerItem("My ListView ", Icons.rss_feed),
    DrawerItem("Hello World", Icons.local_pizza),
    DrawerItem("About Us", Icons.info)
  ];

  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<MyHomePage> {
  int _selectedDrawerIndex = 0;

  String currentProfilePic =
      "https://yt3.ggpht.com/ytc/AKedOLS5kAZSAbS-v_HPwb9TpGbytE74eqHM2S1bLAHqrFE=s176-c-k-c0x00ffffff-no-rj";

  _getDrawerItemWidget(int pos) {
    switch (pos) {
      case 0:
        return FirstFragment();
      case 1:
        return SecondFragment(false);
      case 2:
        return FirstFragment();
      default:
        return const Text("Error");
    }
  }

  _onSelectItem(int index) {
    setState(() => _selectedDrawerIndex = index);
    Navigator.of(context).pop(); // close the drawer
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> drawerOptions = [];
    for (var i = 0; i < widget.drawerItems.length; i++) {
      var d = widget.drawerItems[i];
      drawerOptions.add(ListTile(
        leading: Icon(d.icon),
        title: Text(d.title),
        selected: i == _selectedDrawerIndex,
        onTap: () => _onSelectItem(i),
      ));
    }

    return WillPopScope(
      onWillPop: () async {
        if (_selectedDrawerIndex != 0) {
          setState(() {
            _selectedDrawerIndex = 0;
          });
          _getDrawerItemWidget(_selectedDrawerIndex);
        } else {
          Navigator.pop(context, true);
        }
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.drawerItems[_selectedDrawerIndex].title),
        ),
        drawer: Drawer(
          child: Column(
            children: <Widget>[
              UserAccountsDrawerHeader(
                accountEmail: const Text("sanidhya09@gmail.com"),
                accountName: const Text("Sanidhya Kumar"),
                currentAccountPicture: GestureDetector(
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(currentProfilePic),
                  ),
                  onTap: () => print("This is your current account."),
                ),
              ),
              Column(children: drawerOptions)
            ],
          ),
        ),
        body: _getDrawerItemWidget(_selectedDrawerIndex),
      ),
    );
  }
}
