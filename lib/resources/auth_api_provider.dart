import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart';
import 'package:jvdream/resources/api_urls.dart';
import 'package:jvdream/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthApiProvider {
  Client client = Client();

  Future<LoginResponse> doLoginFetchUserData(
      Map<String, String> loginData) async {
    var headers = {'Content-Type': 'application/x-www-form-urlencoded'};
    final response = await client.post(Uri.parse(ApiURLS.loginURL),
        body: loginData, headers: headers);
    print(json.decode(response.body));

    if (response.statusCode == 200) {
      await storeUserInUserDefault(response.body);
      UserModel amodel = UserModel.fromJson(json.decode(response.body));
      LoginResponse loginResp = LoginResponse(
          message: "User retrieved", status: response.statusCode, user: amodel);
      return loginResp;
    } else {
      return LoginResponse(
          message: json.decode(response.body)["message"],
          status: response.statusCode,
          user: UserModel.dummy());
    }
  }

  Future<LoginResponse> doSingupFetchUserData(
      Map<String, String> signupData) async {
    var headers = {'Content-Type': 'application/x-www-form-urlencoded'};
    final response = await client.post(Uri.parse(ApiURLS.signupURL),
        body: signupData, headers: headers);
    print(json.decode(response.body));

    if (response.statusCode == 200) {
      await storeUserInUserDefault(response.body);
      UserModel amodel = UserModel.fromJson(json.decode(response.body));
      LoginResponse loginResp = LoginResponse(
          message: "User retrieved", status: response.statusCode, user: amodel);

      return loginResp;
    } else {
      return LoginResponse(
          message: json.decode(response.body)["message"],
          status: response.statusCode,
          user: UserModel.dummy());
    }
  }

  storeUserInUserDefault(String userInfo) async {
    SharedPreferences sharedUser = await SharedPreferences.getInstance();
    Map decodeOptions = jsonDecode(userInfo.toString());
    String user = jsonEncode(decodeOptions);
    sharedUser.setString('user', user);
    print("Saveddd-$user");
  }
}
