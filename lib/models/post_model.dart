import 'package:jvdream/models/user_model.dart';

class PostModel {
  late String sid;
  String? textPost;
  String? imagePath;
  UserModel? userModel;
  late String numOflikes;
  late String timeStamp;

  PostModel.fromJson(Map<String, dynamic> parsedJson) {
    sid = parsedJson["_id"];
    textPost = parsedJson["textPost"];
    imagePath = parsedJson["imagePath"];
    numOflikes = parsedJson["numOflikes"].toString();
    timeStamp = parsedJson["timeStamp"];
    userModel = UserModel.fromLocationJson(parsedJson["contactObj"]);
  }

  PostModel.dummy() {
    sid = "";
    numOflikes = "";
    timeStamp = "";
  }
}

class PostDataResponse {
  late List<PostModel> listPosts;
  late int status;
  late String message;

  PostDataResponse({
    required this.status,
    required this.message,
    required this.listPosts,
  });
  PostDataResponse.fromJson(Map<String, dynamic> parsedJson, int statusCode) {
    List<dynamic> data = parsedJson["posts"];
    listPosts = <PostModel>[];
    for (int z = 0; z < data.length; z++) {
      listPosts.add(PostModel.fromJson(data[z]));
    }
    message = parsedJson["message"];
    status = statusCode;
  }
}
/*
 "_id": "63c7b1dcb205602ebc276d6e",
            "textPost": "First postt goo",
            "imagePath": "uploads/imagePost-1674031580389-707035887.png",
            "contactObj": {
                "_id": "63a1a3eee9771f5ce0732233",
                "firstName": "Amit",
                "lastName": "p",
                "email": "amitj@gmail.com"
            },
            "numLikes": 0,
            "timeStamp": "2023-01-18T08:46:20.397Z",
*/