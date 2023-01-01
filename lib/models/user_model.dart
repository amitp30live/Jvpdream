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
  late String phoneNo;
  late String sid;
  late List<dynamic> friendList;
  late String accessToken;
  late String refreshToken;

  UserModel(
      {required this.firstName,
      required this.lastName,
      required this.email,
      required this.phoneNo,
      required this.sid,
      required this.friendList,
      required this.refreshToken,
      required this.accessToken});

  UserModel.fromJson(Map<String, dynamic> userInfo) {
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
}

class LoginResponse extends Object {
  late int status;
  late String message;
  late UserModel user;

  LoginResponse(
      {required this.status, required this.message, required this.user});
}
