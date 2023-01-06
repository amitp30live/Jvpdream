import 'package:flutter/material.dart';

class PostsUI extends StatefulWidget {
  const PostsUI({super.key});

  @override
  State<PostsUI> createState() => _PostsUIState();
}

class _PostsUIState extends State<PostsUI> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(child: Text("Posts")),
    );
  }
}
