import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jvdream/ui/TabScreens/home_list.dart';
import 'package:jvdream/ui/tab_screens/feeds_posts_ui.dart';
import 'package:jvdream/ui/tab_screens/friends_ui.dart';
import 'package:jvdream/ui/tab_screens/settings_ui.dart';

class TabbarPage extends StatefulWidget {
  const TabbarPage({Key? key}) : super(key: key);

  @override
  _TabbarPageState createState() {
    return _TabbarPageState();
  }
}

class _TabbarPageState extends State<TabbarPage> {
  List<Widget> data = [HomeListUI(), PostsUI(), FriendsUI(), SettingsUI()];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: const Text("Nearby Users"),
            centerTitle: true,
            automaticallyImplyLeading: false,
            backgroundColor: Colors.black87,
          ),
          body: CupertinoTabScaffold(
            tabBar: CupertinoTabBar(
              backgroundColor: Colors.black,
              activeColor: Colors.white,
              inactiveColor: Colors.grey,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  // label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.feed),
                  // label: 'Feeds',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.contacts),
                  // label: 'Friends',
                ),
                BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.person),
                  // label: "Profile",
                ),
              ],
            ),
            tabBuilder: (context, index) {
              return CupertinoTabView(
                builder: (context) {
                  return data[index];
                },
              );
            },
          )),
    );
  }
}

class HomeScreenTab extends StatelessWidget {
  const HomeScreenTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "assets/logo.png",
            height: 270,
            width: 350,
          ),
          const Text(
            "This is Home Page",
            style: TextStyle(fontSize: 20),
          ),
        ],
      ),
    );
  }
}

class ProfileScreenTab extends StatelessWidget {
  const ProfileScreenTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "assets/powered_by.png",
            height: 270,
            width: 400,
          ),
          const Text(
            "This is Profile Page",
            style: TextStyle(
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }
}
