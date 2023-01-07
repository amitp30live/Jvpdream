import 'dart:convert';

import 'package:jvdream/models/base_response.dart';
import 'package:jvdream/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

mixin StorePreferneceData {
  BaseDataRes passBaseResponse() {
    return BaseDataRes(message: "No internet Connection", status: 404);
  }

  storeUserInUserDefault(String userInfo) async {
    SharedPreferences sharedUser = await SharedPreferences.getInstance();
    Map decodeOptions = jsonDecode(userInfo.toString());
    String user = jsonEncode(decodeOptions);
    sharedUser.setString('user', user);
    print("Saveddd-$user");
  }

  Future<UserModel?> getUserFromPreference() async {
    SharedPreferences sharedUser = await SharedPreferences.getInstance();

    if (sharedUser.getString('user') != null) {
      Map userMap = jsonDecode(sharedUser.getString('user')!);
      var user = UserModel.fromJson(userMap);
      return user;
    }
    return null;
  }

  removeUserFromPreference() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.remove('user');
  }
}

class Auth with StorePreferneceData {
  Future<bool> isLoggedUser() async {
    UserModel? user = await getUserFromPreference();
    if (user != null) {
      return true;
    }
    return false;
  }

  LoginResponse dummyLoginResponse() {
    return LoginResponse(
        message: "No internet Connection",
        status: 404,
        user: UserModel.dummy());
  }
}

Auth auth = Auth();
