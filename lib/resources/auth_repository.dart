import 'dart:async';

import 'package:jvdream/models/location_model.dart';
import 'package:jvdream/models/user_model.dart';
import 'package:jvdream/resources/api_urls.dart';
import 'package:jvdream/resources/auth_api_provider.dart';
import 'package:jvdream/resources/store_preference.dart';

class AuthRepository {
  final authApiProvider = AuthApiProvider();

  Future<LoginResponse> doLogin(Map<String, String> loginData) async {
    return authApiProvider.doLoginSignupFetchUserData(
        loginData, ApiURLS.loginURL);
  }

  Future<LoginResponse> doSignup(Map<String, String> signupData) async {
    return authApiProvider.doLoginSignupFetchUserData(
        signupData, ApiURLS.signupURL);
  }
}

class LocationRepository {
  final authApiProvider = AuthApiProvider();

  Future<LocationResponse?> addLocationDetails(
      Map<String, String> locationData) async {
    /*authorization:bearer eyJhbGc
    */

    UserModel? model = await auth.loggedUser();
    if (model != null) {
      var headerparams = {
        'Content-Type': 'application/x-www-form-urlencoded',
        'authorization': 'bearer ${model.accessToken}'
      };
      var locationDData = locationData;
      locationDData["contactObj"] = model.sid;
      return authApiProvider.addLocationData(
          locationDData, ApiURLS.addLocationDetailsURL, headerparams);
    }
  }
}
