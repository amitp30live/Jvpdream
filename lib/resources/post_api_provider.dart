import 'dart:convert';

import 'package:http/http.dart';
import 'package:jvdream/models/base_response.dart';
import 'package:jvdream/models/post_model.dart';
import 'package:jvdream/resources/store_preference.dart';

class PostAPIProvider with CheckInternetConnection {
  Client client = Client();

  Future<PostDataResponse> getPostList(Map<String, String> body, String url,
      Map<String, String> headerParams) async {
    var checkConnection = await checkInternetConnectivity();
    if (!checkConnection) {
      return auth.dummyPostDataReqResponse();
    }

    final response =
        await client.post(Uri.parse(url), body: body, headers: headerParams);
    print(json.decode(response.body));

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      return PostDataResponse.fromJson(
        jsonData,
        response.statusCode,
      );
    } else {
      return PostDataResponse(
          message: json.decode(response.body)["message"],
          status: response.statusCode,
          listPosts: []);
    }
  }
}
