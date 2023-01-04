// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:jvdream/ui/InitialUI.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeUI extends StatefulWidget {
  const HomeUI({super.key});

  @override
  State<HomeUI> createState() => _HomeUIState();
}

class _HomeUIState extends State<HomeUI> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: 'Map',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.contacts),
            label: 'Friends',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              height: 200,
            ),
            Text("HOME"),
            TextButton(
                onPressed: () {
                  _doOpenPage(context);
                },
                child: Text("Logout"))
          ],
        ),
      ),
    );
  }

  void _doOpenPage(BuildContext contextMain) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.remove('user');

    Navigator.pushAndRemoveUntil(contextMain,
        MaterialPageRoute(builder: (context) {
      return InitialUI();
    }), ModalRoute.withName('/'));
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
