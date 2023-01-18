// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors

import 'package:flutter/material.dart';

void main() {
  runApp(PostsUI());
}

class PostsUI extends StatefulWidget {
  const PostsUI({super.key});

  @override
  State<PostsUI> createState() => _PostsUIState();
}

class _PostsUIState extends State<PostsUI> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Feed"),
          backgroundColor: Colors.black,
        ),
        body: FutureBuilder(
            future: _getPostData(),
            builder: (context, AsyncSnapshot snapshot) {
              if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              } else {
                Container(
                    child: ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Text('${snapshot.data[index].title}');
                        }));
              }
              return Center(child: CircularProgressIndicator());
            }));
  }

  _getPostData() async {}
}
