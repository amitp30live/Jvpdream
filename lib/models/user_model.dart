import 'package:jvdream/models/base_response.dart';

class UserModel {
  /*
  {
    "message": "User registered successfully",
    "data": {
        "firstName": "Mom",
        "lastName": "p",
        "email": "momlove@gmail.com",
        "password": "$2b$10$aHFyMqDdraEpSu6rTedUmuP0nYSn5Bg0b1lznrxg3yZLGPHveF6JO",
        "phoneNo": 8888899977,
        "friendList": [],
        "_id": "63aecbce9033b178e2ca2aac",
        "created_date": "2022-12-30T11:30:22.603Z",
        "__v": 0
    },
    "accessToken": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjoibW9tbG92ZUBnbWFpbC5jb20iLCJpZCI6IjYzYWVjYmNlOTAzM2IxNzhlMmNhMmFhYyIsIm5hbWUiOiJNb20iLCJpYXQiOjE2NzIzOTk4MjIsImV4cCI6MTY3MzY5NTgyMn0.fScXkLB7EhxhGWyPf4ajaymdJco86eQfa7cWNFCv1Z0",
    "refreshToken": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjoibW9tbG92ZUBnbWFpbC5jb20iLCJpZCI6IjYzYWVjYmNlOTAzM2IxNzhlMmNhMmFhYyIsIm5hbWUiOiJNb20iLCJpYXQiOjE2NzIzOTk4MjIsImV4cCI6MTY3MzY5NTgyMn0.Wzs52n-GB4cjZjlAW3BkV8kfx5VIDoCUGDzTlfKEqQ8"
    }
  */

  late String firstName;
  late String lastName;
  late String email;
  String? phoneNo;
  late String sid;
  List<dynamic>? friendList;
  String? accessToken;
  String? refreshToken;

  UserModel(
      {required this.firstName,
      required this.lastName,
      required this.email,
      this.phoneNo,
      required this.sid,
      this.friendList,
      this.refreshToken,
      this.accessToken});

  UserModel.fromJson(Map<dynamic, dynamic> userInfo) {
    var parsedJson = userInfo["UserInfo"];

    firstName = parsedJson["firstName"];
    lastName = parsedJson["lastName"];
    email = parsedJson["email"];
    phoneNo = parsedJson["phoneNo"].toString();
    sid = parsedJson["_id"].toString();
    friendList = parsedJson["friendList"];
    accessToken = parsedJson["accessToken"];
    refreshToken = parsedJson["refreshToken"];
  }

  UserModel.fromLocationJson(Map<dynamic, dynamic> parsedJson) {
    firstName = parsedJson["firstName"];
    lastName = parsedJson["lastName"];
    email = parsedJson["email"];
    phoneNo = parsedJson["phoneNo"].toString();
    sid = parsedJson["_id"].toString();
    friendList = parsedJson["friendList"];
    accessToken = parsedJson["accessToken"];
    refreshToken = parsedJson["refreshToken"];
  }
  UserModel.dummy() {
    UserModel(
        firstName: "",
        lastName: "",
        email: "",
        phoneNo: "",
        sid: "",
        friendList: [],
        refreshToken: "",
        accessToken: "");
  }
}

class LoginResponse extends BaseDataRes {
  @override
  late int status;
  @override
  late String message;
  late UserModel user;

  LoginResponse(
      {required this.status, required this.message, required this.user})
      : super(message: message, status: status);
}

/*
class StoreUserInPreference {
  static storeUser(Map<String, dynamic> parsedJson) async {
    SharedPreferences sharedUser = await SharedPreferences.getInstance();
    Map decodeOptions = jsonDecode(parsedJson.toString());
    String user = jsonEncode(UserModel.fromJson(decodeOptions));
    sharedUser.setString('user', user);
    log("usererrrrr -- $user");
    return user;
  }

  static fetchUser() async {
    SharedPreferences sharedUser = await SharedPreferences.getInstance();
    if (sharedUser.getString('user') != null) {
      Map userMap = jsonDecode(sharedUser.getString('user')!);
      var user = UserModel.fromJson(userMap);
      print("HERE WE GOOOOO----");
      print(user.email);
      return user;
    }
  }
}
*/