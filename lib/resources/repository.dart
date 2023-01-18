import 'dart:async';

import 'package:jvdream/models/friend_model.dart';
import 'package:jvdream/models/location_model.dart';
import 'package:jvdream/models/post_model.dart';
import 'package:jvdream/models/user_model.dart';
import 'package:jvdream/resources/api_urls.dart';
import 'package:jvdream/resources/auth_api_provider.dart';
import 'package:jvdream/resources/friends_api_provider.dart';
import 'package:jvdream/resources/post_api_provider.dart';
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

  Future<LocationResponse> addLocationDetails(
      Map<String, String> locationData) async {
    /*authorization:bearer eyJhbGc
    */

    var headerparams = {
      'Content-Type': 'application/x-www-form-urlencoded',
      'authorization': 'bearer ${Auth.authUser.accessToken}'
    };
    var locationDData = locationData;
    locationDData["contactObj"] = Auth.authUser.sid;
    return authApiProvider.addLocationData(
        locationDData, ApiURLS.addLocationDetailsURL, headerparams);
  }

  Future<NearbyLocationResponse> nearbyLocationListDetails(
      Map<String, String> locationData) async {
    /*authorization:bearer eyJhbGc
    */

    //  UserModel? model = await auth.loggedUser();
    // if (model != null) {
    var headerparams = {
      'Content-Type': 'application/x-www-form-urlencoded',
      'authorization': 'bearer ${Auth.authUser.accessToken}'
    };
    var locationDData = locationData;
    locationDData["contactObj"] = Auth.authUser.sid;
    return authApiProvider.nearByLocationData(
        locationData, ApiURLS.getNearbyLocationsURL, headerparams);
    // }
  }
}

class FriendsRepository {
  final friendApiProvider = FriendsApiProvider();

  Future<FriendDataResponse> getFriendStatusDetails(
      Map<String, String> reqData) async {
    /*authorization:bearer eyJhbGc
    */

    var headerparams = {
      'Content-Type': 'application/x-www-form-urlencoded',
      'authorization': 'bearer ${Auth.authUser.accessToken}'
    };

    return friendApiProvider.getCurrentStatus(
        reqData, ApiURLS.getFriendStatusURL, headerparams);
  }

  Future<FriendDataResponse> doAsPerRequested(
      Map<String, String> reqData, String url) async {
    /*authorization:bearer eyJhbGc
    */

    var headerparams = {
      'Content-Type': 'application/x-www-form-urlencoded',
      'authorization': 'bearer ${Auth.authUser.accessToken}'
    };

    return friendApiProvider.getCurrentStatus(reqData, url, headerparams);
  }
}

class PostsRepository {
  final postApiProvider = PostAPIProvider();

  Future<PostDataResponse> getPostListData(
      Map<String, String> reqData, String url) async {
    /*authorization:bearer eyJhbGc
    */

    var headerparams = {
      'Content-Type': 'application/x-www-form-urlencoded',
      'authorization': 'bearer ${Auth.authUser.accessToken}'
    };

    return postApiProvider.getPostList(reqData, url, headerparams);
  }

  // Future<FriendDataResponse> doAsPerRequested(
  //     Map<String, String> reqData, String url) async {
  //   /*authorization:bearer eyJhbGc
  //   */

  //   var headerparams = {
  //     'Content-Type': 'application/x-www-form-urlencoded',
  //     'authorization': 'bearer ${Auth.authUser.accessToken}'
  //   };

  //   return friendApiProvider.getCurrentStatus(reqData, url, headerparams);
  // }
}
