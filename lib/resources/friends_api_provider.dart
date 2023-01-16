import 'dart:convert';
import 'package:http/http.dart';
import 'package:jvdream/models/base_response.dart';
import 'package:jvdream/models/friend_model.dart';
import 'package:jvdream/models/location_model.dart';
import 'package:jvdream/resources/api_urls.dart';
import 'package:jvdream/models/user_model.dart';
import 'package:jvdream/resources/store_preference.dart';

class FriendsApiProvider with CheckInternetConnection, StorePreferneceData {
  Client client = Client();

  Future<FriendDataResponse> getCurrentStatus(Map<String, String> body,
      String url, Map<String, String> headerParams) async {
    var checkConnection = await checkInternetConnectivity();
    if (!checkConnection) {
      return auth.dummyFriendReqResponse();
    }

    final response =
        await client.post(Uri.parse(url), body: body, headers: headerParams);
    print(json.decode(response.body));

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      FriendModel amodel = FriendModel.fromJson(jsonData["data"]);
      FriendDataResponse loginResp = FriendDataResponse(
          reqStatus: jsonData["status"],
          message: jsonData["message"],
          status: response.statusCode,
          friendModel: amodel);
      return loginResp;
    } else {
      return FriendDataResponse(
          message: json.decode(response.body)["message"],
          status: response.statusCode,
          reqStatus: "");
    }
  }
}
