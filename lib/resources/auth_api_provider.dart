import 'dart:convert';
import 'package:http/http.dart';
import 'package:jvdream/resources/api_urls.dart';
import 'package:jvdream/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class AuthApiProvider with CheckInternetConnection {
  Client client = Client();

  LoginResponse passBaseissue() {
    return LoginResponse(
        message: "No internet Connection",
        status: 404,
        user: UserModel.dummy());
  }

  Future<LoginResponse> doLoginFetchUserData(
      Map<String, String> loginData) async {
    var checkConnection = await checkInternetConnectivity();
    if (!checkConnection) {
      return passBaseissue();
    }

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

mixin CheckInternetConnection {
  Future<bool> checkInternetConnectivity() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      // I am connected to a mobile network.
      print("MOBILE INTERNET Connection");
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      print("WIFI INTERNET Connection");
      return true;
      // I am connected to a wifi network.
    } else if (connectivityResult == ConnectivityResult.ethernet) {
      print("ethernet INTERNET Connection");
      return true;
    } else if (connectivityResult == ConnectivityResult.none) {
      print("NO INTERNET Connection");
      return false;
    }
    return true;
  }
}
