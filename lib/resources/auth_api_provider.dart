import 'dart:convert';
import 'package:http/http.dart';
import 'package:jvdream/common_widgets/api_urls.dart';
import 'package:jvdream/models/user_model.dart';

class AuthApiProvider {
  Client client = Client();

  Future<UserModel> doLoginFetchUserData(Map<String, String> loginData) async {
    var headers = {'Content-Type': 'application/x-www-form-urlencoded'};
    final response = await client.post(Uri.parse(ApiURLS.loginURL),
        body: loginData, headers: headers);

    if (response.statusCode == 200) {
      print(json.decode(response.body));

      UserModel amodel = UserModel.fromJson(json.decode(response.body));
      print(amodel.email);
      return amodel;
    } else {
      throw Exception('failed to login');
    }
  }
}
