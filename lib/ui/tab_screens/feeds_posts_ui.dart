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
        title: Text("Feed"),
        backgroundColor: Colors.black,
      ),
      body: Container(
        child: Center(child: Text("Posts")),
      ),
    );
  }
}
