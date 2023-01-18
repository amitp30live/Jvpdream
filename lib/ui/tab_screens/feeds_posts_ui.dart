// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:jvdream/blocs/post_bloc.dart';
import 'package:jvdream/models/location_model.dart';
import 'package:jvdream/models/post_model.dart';
import 'package:jvdream/resources/api_urls.dart';
import 'package:jvdream/resources/store_preference.dart';
import 'package:jvdream/ui/screens/otherprofile.dart';
import 'package:jvdream/utils/common_widgets/common_style.dart';

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
                return Container(
                    child: ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext context, int index) {
                          return prepareRow(snapshot.data[index]);
                        }));
              }
            }));
  }

  _getPostData() async {
    //  contactID:63175b945a3875493b5e12f8
    var data = <String, String>{};
    data["contactID"] = Auth.authUser.sid;
    var listPost = await postBloc.getPostsList(data, ApiURLS.getAllPostsURL);
    return listPost;
  }

  Widget prepareRow(PostModel postModel) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => OtherUserProfile(
                      otherUser: postModel.userModel!,
                    )));
        print("Column clicked");
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    imgProfile(""),
                    Container(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CommonWidgets.textWidget(
                          '${postModel.userModel?.firstName} ${postModel.userModel?.lastName}',
                        ),
                        Container(
                          height: 6,
                        ),
                        CommonWidgets.textWidget(
                          'Email: ${postModel.userModel?.email}',
                        ),
                        Container(
                          height: 6,
                        ),
                        CommonWidgets.textWidget(postModel.timeStamp,
                            size: 14, weight: FontWeight.normal),
                      ],
                    ),
                  ],
                ),
                Container(
                  height: 8,
                ),
                Image.file(
                  File(
                      '/Users/amitprajapati/Documents/Be_AP_22/NODE life/NodeCrud/${postModel.imagePath}'),
                  height: 150,
                ),
                Container(
                  height: 8,
                ),
                Row(
                  children: [
                    CommonWidgets.textWidget(
                      '${postModel.textPost}',
                      weight: FontWeight.w500,
                    ),
                  ],
                ),
                Container(
                  height: 6,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget imgProfile(String url) {
    // https://picsum.photos/200
    return CircleAvatar(
        // radius: 56,
        minRadius: 35,
        maxRadius: 35,
        backgroundColor: Colors.grey[350],
        child: Padding(
            padding: const EdgeInsets.all(2), // Border radius
            child: ClipOval(
                child: Image.network(
              'https://picsum.photos/200',
            ))));
  }
}
