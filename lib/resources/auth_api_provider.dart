import 'dart:convert';
import 'package:http/http.dart';
import 'package:jvdream/models/base_response.dart';
import 'package:jvdream/resources/api_urls.dart';
import 'package:jvdream/models/user_model.dart';
import 'package:jvdream/resources/storePreference.dart';

class AuthApiProvider with CheckInternetConnection, StorePreferneceData {
  Client client = Client();

  Future<LoginResponse> doLoginSignupFetchUserData(
      Map<String, String> body, String url) async {
    var checkConnection = await checkInternetConnectivity();
    if (!checkConnection) {
      return auth.dummyLoginResponse();
    }

    var headers = {'Content-Type': 'application/x-www-form-urlencoded'};
    final response =
        await client.post(Uri.parse(url), body: body, headers: headers);
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

  /* Future<LoginResponse> doSingupFetchUserData(
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
  */

}
