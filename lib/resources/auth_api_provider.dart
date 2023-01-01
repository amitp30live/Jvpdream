import 'dart:convert';
import 'package:http/http.dart';
import 'package:jvdream/common_widgets/api_urls.dart';
import 'package:jvdream/models/user_model.dart';

class AuthApiProvider {
  Client client = Client();

  Future<LoginResponse> doLoginFetchUserData(
      Map<String, String> loginData) async {
    var headers = {'Content-Type': 'application/x-www-form-urlencoded'};
    final response = await client.post(Uri.parse(ApiURLS.loginURL),
        body: loginData, headers: headers);

    if (response.statusCode == 200) {
      print(json.decode(response.body));

      UserModel amodel = UserModel.fromJson(json.decode(response.body));
      print(amodel.email);
      LoginResponse loginResp = LoginResponse(
          message: "User retrieved", status: response.statusCode, user: amodel);
      return loginResp;
    } else {
      UserModel user = UserModel(
          firstName: "",
          lastName: "",
          email: "",
          phoneNo: "",
          sid: "",
          friendList: [],
          refreshToken: "",
          accessToken: "");
      return LoginResponse(
          message: "OPSss.. Failed..", status: response.statusCode, user: user);
      // throw Exception('failed to login');
    }

    /*
     final response = await client
        .post(Uri.parse(ApiURLS.loginURL), body: loginData, headers: headers)
        .then((response) => {
       LoginResponse(
          message: "User retrieved", status: response.statusCode, user: UserModel.fromJson(json.decode(response.body)))
        })
        .catchError((e) => {
          LoginResponse(
          message: "User retrieved", status: 400, user: null)
        });
    */
  }
}
