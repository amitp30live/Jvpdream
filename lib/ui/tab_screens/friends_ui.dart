import 'package:flutter/material.dart';

class FriendsUI extends StatefulWidget {
  const FriendsUI({super.key});

  @override
  State<FriendsUI> createState() => _FriendsUIState();
}

class _FriendsUIState extends State<FriendsUI> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Friends"),
        backgroundColor: Colors.black,
      ),
      body: Container(
        child: Center(child: Text("Friends")),
      ),
    );
  }
}
