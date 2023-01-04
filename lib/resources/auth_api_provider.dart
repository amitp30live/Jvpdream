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
      SharedPreferences shared_User = await SharedPreferences.getInstance();
      Map decode_options = jsonDecode(response.body.toString());
      print("decode_options----$decode_options");

      String user = jsonEncode(decode_options);

      shared_User.setString('user', user);
      print("USERRERRERE----$user");

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
      UserModel amodel = UserModel.fromJson(json.decode(response.body));
      LoginResponse loginResp = LoginResponse(
          message: "User retrieved", status: response.statusCode, user: amodel);

      return loginResp;
    } else {
      return LoginResponse(
          message: json.decode(response.body)["message"],
          status: response.statusCode,
          user: UserModel.dummy());
      // throw Exception('failed to login');
    }
  }
}
