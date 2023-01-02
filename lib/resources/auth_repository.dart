import 'package:jvdream/models/user_model.dart';
import 'package:jvdream/resources/auth_api_provider.dart';

class AuthRepository {
  final authApiProvider = AuthApiProvider();

  Future<LoginResponse> doLogin(Map<String, String> loginData) async {
    return authApiProvider.doLoginFetchUserData(loginData);
  }

  Future<LoginResponse> doSignup(Map<String, String> signupData) async {
    return authApiProvider.doSingupFetchUserData(signupData);
  }
}
